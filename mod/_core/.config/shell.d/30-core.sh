#!/usr/bin/env bash
#
# Common login shell profile
#

# Append bin directories to path
prepend_path "${DOTFILES_DIR}/bin"
prepend_path "${HOME}/.local/bin"

# Go to the dotfiles directory
if [ -n "${DOTFILES_DIR}" ]; then
  alias dotdir='cd ${DOTFILES_DIR}'
fi

# Code directory
export CODE_DIR="${CODE_DIR:-$HOME/src}"
if [ -d "${CODE_DIR}" ]; then
  alias codedir='cd ${CODE_DIR}'
else
  unset CODE_DIR
fi

