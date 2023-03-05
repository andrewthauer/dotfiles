#!/usr/bin/env bash

# Usage: use_op_env [<account_url>]
#
# Loads 1Password environment variables into the current shell.
# `DIRENV_LOAD_OP_ENV` environment variable needs to be set.
use_op_env() {
  local account="${1:-my.1password.com}"

  if [ -n "$DIRENV_LOAD_OP_ENV" ]; then
    if ! has op; then
      log_error "1password CLI is not installed"
    fi

    log_status "Loading 1Password environment variables ..."

    if [ -n "$account" ]; then
      op signin --account "$account" || {
        log_error "Unable to signin to $account"
        return 1
      }
    fi

    direnv_load op run -- direnv dump || {
      log_error "Error running op run"
      return 1
    }
  fi
}
