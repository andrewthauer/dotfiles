#
# Initialize nvm environment
#

# Replace vim with neovim
if [ -x "$(command -v nvim)" ]; then
  alias vi='nvim'
  alias vim='nvim'
fi

nvim-plugin-install() {
  nvim +PlugInstall +qall
}
