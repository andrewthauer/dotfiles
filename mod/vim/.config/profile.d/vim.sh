#
# Vim environment
#

# Remap ~/.vimrc for XDG specification
if [ -f "$XDG_CONFIG_HOME/nvim/init.lua" ]; then
  export VIMINIT=":source $XDG_CONFIG_HOME/nvim/init.lua"
elif [ -f "$XDG_CONFIG_HOME/nvim/init.vim" ]; then
  export VIMINIT=":source $XDG_CONFIG_HOME/nvim/init.vim"
fi
