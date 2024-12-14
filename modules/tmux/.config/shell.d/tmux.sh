#
# Tmux aliases
#

if ! command_exists "tmux"; then
  return 1
fi

# tmux xdg configration (added in v3.1)
# alias tmux='tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf'

# aliases
alias tmuxa='tmux new-session -A'
alias tmuxl='tmux list-sessions'
alias tmuxs='tmux start-server'
