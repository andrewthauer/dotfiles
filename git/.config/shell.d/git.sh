#
# Initialize git environment
#

if ! command_exists "git"; then
  return
fi

#
# Aliases
#

alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gba="git branch -a"
alias gbackup="git backup-branch"
alias gbd="git branch -d"
alias gci="git commit"
alias gcis="git cis"
alias gcisb="git cisb"
alias gcb="git checkout -b"
alias gcf="git config --list"
alias gcm="git checkout master"
alias gcim="git commit -m"
alias gcisb="git cisb"
alias gco="git checkout"
alias gd="git diff"
alias glogd="git logd"
alias gpushu="git pushu"
alias gpushf="git pushf"
alias grm="git rebase -i master"
alias grc="git rebase --continue"
alias gsb="git squashbase"
alias gst="git status"
alias gwt="git worktree"
