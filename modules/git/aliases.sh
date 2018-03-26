#
# Git helpers & aliases
#

# Skip if git is not installed
if ! [[ -x "$(command -v git)" ]]; then
  return
fi

alias g="git"

# A
alias ga='git add'
alias gaa='git add --all'

# B
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'

# C
alias gc='git commit -v'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcl='git clone --recursive'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gco='git checkout'

# D
alias gd='git diff'

# S
alias gst="git status"
alias gstu="git status --untracked-files"

# W
alias gwt="git worktree"
