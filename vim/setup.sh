#!/usr/bin/env bash

VIM_DIR="${DOTFILES_DIR}/vim"
VIM_PACK_DIR="${VIM_DIR}/pack/default"

# Create a settings directory
mkdir -p "${VIM_DIR}/settings"

# Install vim plugins
vim-pack 'editorconfig/editorconfig-vim'
vim-pack 'vim-scripts/Zenburn'
vim-pack 'sheerun/vim-polyglot'
vim-pack 'w0rp/ale'
vim-pack 'junegunn/fzf'
vim-pack 'neoclide/coc.nvim'
vim-pack 'neoclide/coc-tsserver'
