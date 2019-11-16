#
# Setup homebrew environment
#

# Set brew prefix if macos to avoid using "$(brew --prefix)"
if [[ "$OSTYPE" == darwin* ]]; then
  BREW_PREFIX="${BREW_PREFIX:-/usr/local}"
fi
