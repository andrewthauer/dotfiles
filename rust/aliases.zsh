#
# Rust helpers & aliases
#

# Skip if rust is not installed
if (( ! $+commands[rustc] )); then
  return
fi

# Aliases
