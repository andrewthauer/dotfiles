#
# Git helpers & aliases
#

# Skip if git is not installed
if [[ ! -x "$(command -v git)" ]]; then
  return
fi

alias g="git"

# A
alias ga="git add"
alias gaa="git add --all"

# B
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"

# C
alias gci="git commit"
alias gcb="git checkout -b"
alias gcf="git config --list"
alias gcm="git checkout master"
alias gcim="git commit -m"
alias gcisb="git cisb"
alias gco="git checkout"

# D
alias gd="git diff"

# P
alias gpushu="git pushu"
alias gpushf="git pushf"

# R
alias grm="git rebase -i master"
alias grc="git rebase --continue"

# S
alias gsb="git squashbase"
alias gst="git status"

# W
alias gwt="git worktree"
