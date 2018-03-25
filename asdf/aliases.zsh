#
# asdf related aliases
#

# Skip if asdf is not installed
if ! [ -x "$(command -v asdf)" ]; then
  return
fi

# Aliases
alias asdfc="asdf current"
