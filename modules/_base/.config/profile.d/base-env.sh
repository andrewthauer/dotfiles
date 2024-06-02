#
# Common environment user session
#

# Terminal
# export TERM="xterm"

# Editor
export EDITOR="nvim"
export VISUAL="nvim -b"

# Colors
export CLICOLOR=1

# Pager
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export LESS="-F -g -i -M -R -S -w -X -z-4"
export LESSCHARSET="utf-8"
export PAGER="less"

# Set the Less input preprocessor
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN="|lesspipe.sh %s"
fi
