#
# Elm helpers & aliases
#

# Skip if elm is not installed
if (( ! $+commands[elm] )); then
  return
fi

# Aliases
alias em='elm make'
alias er='elm repl'
alias epi='elm package install'
