#
# Initialize git environment
#

#
# Aliases
#

alias g='git'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git cm'
alias gs='git switch'
alias gst='git status'
alias gwt='git worktree'

#
# Fuzzy
#

gfs() {
  # shellcheck disable=SC2046
  git checkout $(git fuzzy branch)
}
