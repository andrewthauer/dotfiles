#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable zprof performance profiling
[[ -n $PROFILE_STARTUP ]] && zmodload zsh/zprof

#
# Start oh-my-zsh
#

# Path to your oh-my-zsh installation.
export ZSH="${XDG_DATA_HOME}/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=($plugins git)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

#
# End oh-my-zsh
#

# Source common interactive shell scripts
source_files_in "$XDG_CONFIG_HOME"/shell.d/*.sh
