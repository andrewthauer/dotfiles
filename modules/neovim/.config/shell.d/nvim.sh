#
# Initialize nvm environment
#

nvim-plugin-install() {
  nvim +PlugInstall +qall
}

alias vin="NVIM_LAZYVIM=false nvim"
