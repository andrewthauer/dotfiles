#!/usr/bin/env bash

# Usage:
#   use_op_env [<account_url>]
#
# Example:
#   use_op_env my.1password.com
#
#   use_op_env my.1password.com && {
#     echo "1Password environment variables loaded"
#     dotenv_if_exists .env-post-op-env
#   }
#
# Loads 1Password environment variables into the current shell.
# `DIRENV_LOAD_OP_ENV` environment variable needs to be set.
use_op_env() {
  local account="${1:-my.1password.com}"

  log_status "loading 1password environment variables"

  if ! has op; then
    log_error "1password CLI is not installed"
    return 1
  fi

  if [ -n "$account" ]; then
    op signin --account "$account" || {
      log_error "unable to signin to $account"
      return 1
    }
  fi

  direnv_load op run -- direnv dump || {
    log_error "running op run"
    return 1
  }

  return 0
}
