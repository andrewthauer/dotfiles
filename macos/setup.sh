#!/usr/bin/env sh
#
# Setup macOS System
#

# Exit on error or unset variable
set -o nounset
set -o errexit
set -o pipefail

# Current directory
local dir="$(dirname "$0")"

# Prompt for sudo up front
sudo -v

#
# Run scripts
#

# source "$dir/system/base.sh"
# source "$dir/system/defaults.sh"
# source "$dir/system/brew.sh"
# source "$dir/system/zsh.sh"
# source "$dir/system/node.sh"
# source "$dir/system/ruby.sh"
# source "$dir/system/brews.sh"
# source "$dir/system/casks.sh"
