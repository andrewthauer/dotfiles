#
# Tmux aliases
#

if ! command_exists "tmux"; then
  return 1
fi

# export TMUX_TMPDIR="$XDG_RUNTIME_DIR/tmux"
# export TMUX_TMPDIR="$XDG_CONFIG_HOME/tmux"

alias tmux='tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf'
alias tmuxa='tmux new-session -A'
alias tmuxl='tmux list-sessions'
alias tmuxs='tmux start-server'
