#
# Tmux aliases
#

if ! command_exists "tmux"; then
  return 1
fi

alias tmuxa='tmux new-session -A'
alias tmuxl='tmux list-sessions'
alias tmuxs='tmux start-server'
