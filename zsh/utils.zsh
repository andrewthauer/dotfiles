#
# Common utilities
#

time_zsh() {
  time zsh -i -c exit
}

dotfiles_setup() {
  $DOTFILES_DIR/setup
}
