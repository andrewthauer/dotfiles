#!/usr/bin/env bash
#
# Common login shell profile
#

# Append bin directories to path
prepend_path "${DOTFILES_DIR}/bin"
prepend_path "${HOME}/.local/bin"
