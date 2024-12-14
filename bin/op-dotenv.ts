#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env --allow-run
/* vim: set filetype=typescript : */
/*

  Usage: op-dotenv.ts <dotenv_path> [--export]

  Examples:

    # Alias dotfile file into environment
    alias ope='eval $(op-dotenv "$HOME/.config/.env" --export)'

    # Load dotfile file into environment
    ope() {
      local env_file="${1:-$HOME/.config/.env}"
      export $(op-dotenv "$env_file" | xargs)
    }
*/

import $ from 'jsr:@david/dax';
import { parse, stringify } from 'jsr:@bearz/dotenv';
import { expand } from 'jsr:@bearz/dotenv/expand';

async function main() {
  // note: currently assumes path is first arg to the dotenv file
  const path = Deno.args?.[0];
  if (!path) {
    console.error('op-dotenv <dotenv_path> [--export]');
    Deno.exit(1);
  }

  // read, parse, resolve secrets, and expand the environment variables
  const envPath = $.path(path).resolve();
  let env: Record<string, string> = parse(await envPath.readText());
  const secretsEnv = await $`op inject`.stdinText(stringify(env)).text();
  env = expand(parse(secretsEnv));

  // output the environment variables
  if (Deno.args.includes('--export')) {
    Object.entries(env).forEach(([key, value]) => {
      console.log(`export ${key}="${value}"`);
    });
  } else if (Deno.args.includes('--launchctl')) {
    Object.entries(env).forEach(async ([key, value]) => {
      await $.raw`launchctl setenv ${key} "${value ?? ''}"`;
    });
  } else {
    console.log(stringify(env));
  }
}

await main();
