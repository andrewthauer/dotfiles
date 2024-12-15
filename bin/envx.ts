#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env --allow-run
/* vim: set filetype=typescript : */

import $ from 'jsr:@david/dax';
import { parse, stringify } from 'jsr:@bearz/dotenv';
import { expand } from 'jsr:@bearz/dotenv/expand';
import { parseArgs } from 'jsr:@std/cli';

type EnvMap = Record<string, string>;

async function main() {
  const args = parseArgs(Deno.args, {
    boolean: ['export', 'op-inject', 'launchctl-set'],
    string: ['_'],
  });

  const paths = args._ as string[];
  if (!paths || paths.length === 0) {
    console.error(
      'usage: [--export | --launchctl-set] [--op-inject] <...path>',
    );
    Deno.exit(1);
  }

  // read, parse, resolve secrets, and expand the environment variables
  let env = await readEnvFiles(paths);

  // inject secrets if requested
  if (args['op-inject']) {
    env = await injectSecrets(env);
  }

  // expand the environment variables
  env = expand(env);

  // process the results
  switch (true) {
    case args.export:
      processEnv(env, (k, v) => console.log(`export ${k}="${v}"`));
      break;
    case args['launchctl-set']:
      processEnv(
        env,
        async (k, v) => {
          await $.raw`launchctl setenv ${k} "${v ?? ''}"`;
        },
      );
      break;
    default:
      console.log(stringify(env));
  }
}

async function readEnvFiles(paths: string[]): Promise<EnvMap> {
  const envMaps = await Promise.all(paths.map(async (path) => {
    const envPath = $.path(path).resolve();
    return parse(await envPath.readText());
  }));

  return envMaps.reduce((acc, env) => ({ ...acc, ...env }), {});
}

async function injectSecrets(env: EnvMap): Promise<EnvMap> {
  const secretsEnv = await $`op inject`.stdinText(stringify(env)).text();
  return parse(secretsEnv);
}

function processEnv(
  env: EnvMap,
  fn: (key: string, value: string) => Promise<void> | void,
) {
  Object.entries(env).forEach(async ([key, value]) => {
    await fn(key, value);
  });
}

await main();
