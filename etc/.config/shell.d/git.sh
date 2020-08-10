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
alias gd='git diff'
alias gs='git switch'
alias gst='git status'
alias gwt='git worktree'
