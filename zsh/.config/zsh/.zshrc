#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable zprof performance profiling
[[ -n $PROFILE_STARTUP ]] && zmodload zsh/zprof

# Source zsh core scripts
source_files_in $XDG_CONFIG_HOME/zsh/init.d/*.zsh
