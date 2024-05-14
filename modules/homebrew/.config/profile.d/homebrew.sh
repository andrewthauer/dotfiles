#
# Initialize homebrew
#

# XDG specification
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"

# Do not create a lock file
export HOMEBREW_BUNDLE_NO_LOCK

# No dev hints
export HOMEBREW_NO_ENV_HINTS

# Source the homebrew shellenv
source_file "${XDG_CONFIG_HOME:-$HOME/.config}/homebrew/shellenv.sh"
