#
# asdf related aliases
#

# Skip if docker is not installed
if (( ! $+commands[asdf] )); then
  return
fi

# Aliases
alias asdfc="asdf current"
