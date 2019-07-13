#!/usr/bin/env bash
#
# Update rust completions
#

set -e

rustup completions bash >| "${DOTFILES_MODULES_DIR}/rust/completions/bash/rustup"
rustup completions zsh >| "${DOTFILES_MODULES_DIR}/rust/completions/zsh/_rustup"

exit 0
