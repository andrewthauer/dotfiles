/**
 * Script to backup Zed settings with sensitive keys filtered out
 * Usage: zed-backup [--exclude key1,key2] [--include key3,key4] [--dry-run] [--help]
 */

import { parse } from 'jsr:@std/jsonc';
import { parseArgs } from 'jsr:@std/cli';

const DEFAULT_EXCLUDE_KEYS = [
  'context_servers',
  'language_models',
];

const DEFAULT_INCLUDE_KEYS = [
  'context_servers.container-use',
];

const DEFAULT_SETTINGS_FILE = `${
  Deno.env.get('HOME')
}/.config/zed/settings.json`;

const DEFAULT_BACKUP_FILE = `${
  Deno.env.get('DOTFILES_HOME')
}/modules/zed/.config/zed/settings-safe.json`;

function showHelp() {
  console.log(`
Usage: zed-backup [options]

Options:
  --exclude key1,key2    Keys to exclude (comma-separated)
  --include key3,key4    Keys to include even if parent is excluded
  --dry-run             Preview output without saving
  --help, -h            Show this help message

Examples:
  zed-backup                           # Use defaults, save to file
  zed-backup --dry-run                 # Preview with defaults
  zed-backup --exclude context_servers,language_models
  zed-backup --include context_servers.container-use
`);
}

function filterSettings(
  settings: Record<string, unknown>,
  excludeKeys: string[],
  includeKeys: string[],
) {
  const filtered = JSON.parse(JSON.stringify(settings));

  // Process each exclude key
  for (const excludeKey of excludeKeys) {
    // Check if any include keys are children of this exclude key
    const hasIncludedChildren = includeKeys.some((includeKey) =>
      includeKey.startsWith(excludeKey + '.')
    );

    if (hasIncludedChildren) {
      // Filter the parent object to only include specified children
      const parentValue = filtered[excludeKey];
      if (typeof parentValue === 'object' && parentValue !== null) {
        const newParentValue: Record<string, unknown> = {};
        for (const includeKey of includeKeys) {
          if (includeKey.startsWith(excludeKey + '.')) {
            const childKey = includeKey.substring(excludeKey.length + 1);
            if (childKey in (parentValue as Record<string, unknown>)) {
              newParentValue[childKey] =
                (parentValue as Record<string, unknown>)[childKey];
            }
          }
        }
        filtered[excludeKey] = newParentValue;
      }
    } else {
      // No included children, safe to delete the entire key
      delete filtered[excludeKey];
    }
  }

  return filtered;
}

async function main() {
  const args = parseArgs(Deno.args, {
    string: ['exclude', 'include'],
    boolean: ['dry-run', 'help'],
    alias: { h: 'help' },
  });

  if (args.help) {
    showHelp();
    return;
  }

  const excludeKeys = args.exclude
    ? args.exclude.split(',').map((k) => k.trim())
    : DEFAULT_EXCLUDE_KEYS;
  const includeKeys = args.include
    ? args.include.split(',').map((k) => k.trim())
    : DEFAULT_INCLUDE_KEYS;

  if (!Deno.env.get('HOME') || !Deno.env.get('DOTFILES_HOME')) {
    console.error('Error: HOME or DOTFILES_HOME environment variable not set');
    Deno.exit(1);
  }

  const settingsFile = DEFAULT_SETTINGS_FILE;
  const backupFile = DEFAULT_BACKUP_FILE;

  try {
    const settingsText = await Deno.readTextFile(settingsFile);
    const settings = parse(settingsText);
    const filtered = filterSettings(
      settings as Record<string, unknown>,
      excludeKeys,
      includeKeys,
    );
    const outputJson = JSON.stringify(filtered, null, 2);

    if (args['dry-run']) {
      console.error(
        '# Dry run mode - filtered settings output (use without --dry-run to save to file):',
      );
      console.error(`# Would save to: ${backupFile}`);
      console.log(outputJson);
    } else {
      await Deno.writeTextFile(backupFile, outputJson);
      console.error(`Zed settings backed up to ${backupFile}`);
    }

    if (excludeKeys.length > 0) {
      console.error(`# Excluded keys: ${excludeKeys.join(', ')}`);
    }
    if (includeKeys.length > 0) {
      console.error(
        `# Included keys (overriding exclusions): ${includeKeys.join(', ')}`,
      );
    }
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
