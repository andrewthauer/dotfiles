#
# Some circleci cli aliases
#

# shellcheck disable=SC2142

if ! command_exists "circleci"; then
  return 1
fi

#
# Aliases
#

alias cci='circleci'
alias ccio='circleci open'
alias cciv='circleci config validate'
alias cciorb='circleci orb validate'
alias cciov='circleci orb validate'
