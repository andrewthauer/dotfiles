#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env --allow-run
/*
  Usage: op-dotenv.ts <dotenv_path> [--export]

  Examples:

    # Alias dotfile file into environment
    alias ope='eval $(op-dotenv2.ts "$HOME/.config/.env" --export)'

    # Load dotfile file into environment
    ope() {
      local env_file="${1:-$HOME/.config/.env}"
      export $(op-dotenv2.ts "$env_file" | xargs)
    }
*/

import * as dotenv from "https://deno.land/std@0.184.0/dotenv/mod.ts";
import $ from "https://deno.land/x/dax@0.31.1/mod.ts";
import { substitute } from "https://deno.land/x/substitute@v0.2.1/mod.ts";

// parse the args (note: currently assumes path is first arg)
const envPath = Deno.args[0];
if (!envPath) {
  console.error("op-dotenv.ts <dotenv_path> [--export]")
  Deno.exit(1);
}

// load the dotenv file
let env = dotenv.loadSync({ envPath });

// resolve environment variables from 1password cli
const rawEnv = await $`op inject`.stdinText(dotenv.stringify(env)).text();

// parse the environment variables
env = dotenv.parse(rawEnv);

// substitute environment variables
Object.entries(env).forEach(([key, value]) => {
  Deno.env.set(key, value);
  const newValue = substitute(value, Deno.env.get);
  Deno.env.set(key, newValue);
  env[key] = newValue;
});

// output the environment variables
if (Deno.args.includes("--export")) {
  Object.entries(env).forEach(([key, value]) => {
    console.log(`export ${key}="${value}"`);
  });
} else {
  console.log(dotenv.stringify(env));
}
