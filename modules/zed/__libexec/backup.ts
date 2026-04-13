/**
 * Script to backup Zed settings with sensitive keys filtered out.
 *
 * Filtering works like a gitignore: exclude paths are evaluated first,
 * then include paths negate them. Paths use dot-notation at any depth:
 *   top_key
 *   parent.child
 *   parent.child.grandchild
 *
 * Usage: zed-backup [--exclude path1,path2] [--include path3,path4] [--dry-run] [--help]
 */

import { parse } from "jsr:@std/jsonc";
import { parseArgs } from "jsr:@std/cli";

type NestedObject = Record<string, unknown>;

// Paths to exclude from the backup (dot-notation, any depth).
const DEFAULT_EXCLUDE_PATHS: string[] = [
  "agent.default_model",
  "agent.default_profile",
  "agent.inline_assistant_model",
  "agent.tool_permissions",
  "agent_servers",
  "context_servers",
  "language_models",
];

// Paths to restore even if an ancestor was excluded (negates exclusions).
const DEFAULT_INCLUDE_PATHS: string[] = [];

const DEFAULT_SETTINGS_FILE = `${
  Deno.env.get("HOME")
}/.config/zed/settings.json`;

const DEFAULT_BACKUP_FILE = `${
  Deno.env.get("DOTFILES_HOME")
}/modules/zed/.config/zed/settings-safe.json`;

// ---------------------------------------------------------------------------
// Path helpers
// ---------------------------------------------------------------------------

/** Read the value at a dot-notation path; returns undefined if missing. */
function getAtPath(obj: NestedObject, parts: string[]): unknown {
  let cur: unknown = obj;
  for (const key of parts) {
    if (typeof cur !== "object" || cur === null) return undefined;
    cur = (cur as NestedObject)[key];
  }
  return cur;
}

/** Delete the node at a dot-notation path. No-op if path does not exist. */
function deleteAtPath(obj: NestedObject, parts: string[]): void {
  if (parts.length === 0) return;
  if (parts.length === 1) {
    delete obj[parts[0]];
    return;
  }
  const [head, ...rest] = parts;
  const child = obj[head];
  if (typeof child === "object" && child !== null) {
    deleteAtPath(child as NestedObject, rest);
  }
}

/**
 * Set the value at a dot-notation path, creating intermediate objects as
 * needed (similar to mkdir -p before writing a file).
 */
function setAtPath(obj: NestedObject, parts: string[], value: unknown): void {
  if (parts.length === 0) return;
  if (parts.length === 1) {
    obj[parts[0]] = value;
    return;
  }
  const [head, ...rest] = parts;
  if (typeof obj[head] !== "object" || obj[head] === null) {
    obj[head] = {};
  }
  setAtPath(obj[head] as NestedObject, rest, value);
}

// ---------------------------------------------------------------------------
// Core filter
// ---------------------------------------------------------------------------

/**
 * Return a filtered copy of settings:
 *   1. Apply every exclude path (delete that node).
 *   2. Apply every include path (restore the original value, even if an
 *      ancestor was excluded - intermediate objects are recreated).
 */
function filterSettings(
  settings: NestedObject,
  excludePaths: string[],
  includePaths: string[],
): NestedObject {
  const filtered: NestedObject = JSON.parse(JSON.stringify(settings));

  // Step 1: exclusions
  for (const path of excludePaths) {
    deleteAtPath(filtered, path.split("."));
  }

  // Step 2: inclusions (restore from original)
  for (const path of includePaths) {
    const parts = path.split(".");
    const original = getAtPath(settings, parts);
    if (original !== undefined) {
      setAtPath(filtered, parts, JSON.parse(JSON.stringify(original)));
    }
  }

  return filtered;
}

// ---------------------------------------------------------------------------
// CLI
// ---------------------------------------------------------------------------

function showHelp(): void {
  console.log(`
Usage: zed-backup [options]

Options:
  --exclude path1,path2  Paths to exclude (comma-separated, dot-notation)
  --include path3,path4  Paths to include even if an ancestor is excluded
  --dry-run              Preview output without saving
  --help, -h             Show this help message

Path format examples:
  top_key
  parent.child
  parent.child.grandchild

Examples:
  zed-backup                            # Use defaults, save to file
  zed-backup --dry-run                  # Preview with defaults
  zed-backup --exclude context_servers,language_models
  zed-backup --include context_servers.container-use
`);
}

async function main(): Promise<void> {
  const args = parseArgs(Deno.args, {
    string: ["exclude", "include"],
    boolean: ["dry-run", "help"],
    alias: { h: "help" },
  });

  if (args.help) {
    showHelp();
    return;
  }

  if (!Deno.env.get("HOME") || !Deno.env.get("DOTFILES_HOME")) {
    console.error(
      "Error: HOME or DOTFILES_HOME environment variable is not set",
    );
    Deno.exit(1);
  }

  const excludePaths = args.exclude
    ? args.exclude.split(",").map((p) => p.trim()).filter(Boolean)
    : DEFAULT_EXCLUDE_PATHS;

  const includePaths = args.include
    ? args.include.split(",").map((p) => p.trim()).filter(Boolean)
    : DEFAULT_INCLUDE_PATHS;

  const settingsFile = DEFAULT_SETTINGS_FILE;
  const backupFile = DEFAULT_BACKUP_FILE;

  try {
    const settingsText = await Deno.readTextFile(settingsFile);
    const settings = parse(settingsText) as NestedObject;
    const filtered = filterSettings(settings, excludePaths, includePaths);
    const outputJson = JSON.stringify(filtered, null, 2);

    if (args["dry-run"]) {
      console.error("# Dry run - preview only (omit --dry-run to save)");
      console.error(`# Would save to: ${backupFile}`);
      console.log(outputJson);
    } else {
      await Deno.writeTextFile(backupFile, outputJson);
      console.error(`Backed up to ${backupFile}`);
    }

    console.error(`# Excluded: ${excludePaths.join(", ") || "(none)"}`);
    console.error(`# Included: ${includePaths.join(", ") || "(none)"}`);
  } catch (error) {
    console.error(
      `Error: ${error instanceof Error ? error.message : String(error)}`,
    );
    Deno.exit(1);
  }
}

if (import.meta.main) {
  main();
}
