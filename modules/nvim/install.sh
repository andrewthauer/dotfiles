#!/usr/bin/env bash

install_vim_plug() {
  echo "Installing vim-plug"
  mkdir -p "$(XDG_DATA_HOME)/nvim/site/autoload"
  curl -sfLo "$(XDG_DATA_HOME)/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_plugins() {
  echo "Install plugins"
  nvim +PlugInstall +qall
}

main() {
  install_vim_plug
  install_plugins
}

main "$@"
