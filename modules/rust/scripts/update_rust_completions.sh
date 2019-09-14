#!/usr/bin/env bash
#
# Update rust completions
#

set -e

rustup completions bash >| "~/.local/share/bash-completion/rustup"
rustup completions zsh >| "~/.local/share/zfunctions/_rustup"

exit 0
