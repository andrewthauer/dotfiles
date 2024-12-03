#!/usr/bin/env bash

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

/bin/launchctl setenv XDG_CONFIG_HOME "$XDG_CONFIG_HOME"
/bin/launchctl setenv XDG_DATA_HOME "$XDG_DATA_HOME"
/bin/launchctl setenv XDG_CACHE_HOME "$XDG_CACHE_HOME"
/bin/launchctl setenv XDG_STATE_HOME "$XDG_STATE_HOME"
/bin/launchctl setenv XDG_BIN_HOME "$XDG_BIN_HOME"
