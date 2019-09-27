#!/usr/bin/env bash
#
# Update rust completions
#

set -e

rustup completions bash >| "${XDG_DATA_HOME}/bash-completion/rustup"
rustup completions zsh >| "${XDG_DATA_HOME}/zsh/functions/_rustup"

exit 0
