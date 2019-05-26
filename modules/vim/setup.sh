#
# Setup Vim
#

vim_setup_plugins() {
  github install 'editorconfig/editorconfig-vim'
  github install 'vim-scripts/Zenburn'
  github install 'sheerun/vim-polyglot'
  github install 'junegunn/fzf'
  github install 'neoclide/coc.nvim' --post-install "yarn install --frozen-lockfile"
}

vim_setup_symlinks() {
  symlink '.' '~/.vim'
  symlink '.' '~/.config/nvim'
  symlink '.vimrc' '~/.vimrc'
  symlink '.vimrc' '~/.config/nvim/init.vim'
  symlink '/usr/local/bin/nvim' '/usr/local/bin/vi'
}

vim_setup_exec() {
  cmd=$1
  args=${@:2}
  cmd_task="vim_setup_${cmd}"

  # Execute either a sub command or all
  if [ $(command -v $cmd_task) ]; then
    $cmd_task $args 2>&1
  else
    vim_setup_plugins
    vim_setup_symlinks
  fi
}

vim_setup_exec $@
exit 0
