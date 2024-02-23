#!/usr/bin/env bash
#
# Common environment user session
#

# XDG configuration
# - https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Terminal
export TERM="xterm"

# Editor
export EDITOR="nvim"
export VISUAL="${EDITOR}"

# Colors
export CLICOLOR=1

# Pager
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export LESS="-F -g -i -M -R -S -w -X -z-4"
export LESSCHARSET="utf-8"
export PAGER="less"

# Set the Less input preprocessor
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN="|lesspipe.sh %s"
fi
