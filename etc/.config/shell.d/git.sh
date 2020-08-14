#
# Initialize git environment
#

if ! command_exists "git"; then
  return
fi

#
# Aliases
#

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gci='git commit'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gco='git checkout'
alias gcd='git checkout -b'
alias gcm='git cm'
alias gd='git diff'
alias gs='git switch'
alias gsc='git switch -c'
alias gsd='git sd'
alias gst='git status -sb'
alias gwt='git worktree'
