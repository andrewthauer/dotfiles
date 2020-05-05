#!/usr/bin/env bash
#
# Setup vim
#

# yarn_install="--post-install yarn install"

# mkdir -p "${HOME}/.config/nvim"
# mkdir -p "${XDG_DATA_HOME}"/vim/{undo,site,swap,backup}
# mkdir -p "${VIM_PACK_DIR}"/default/{opt,start}

gem install neovim
npm install -g neovim
pip install neovim pyx

# theme
vimpack install 'vim-scripts/Zenburn'

# general
# vimpack install 'tpope/vim-sensible'
# vimpack install 'vim-airline/vim-airline'
# vimpack install 'junegunn/fzf'
# vimpack install 'junegunn/fzf.vim'
# vimpack install 'junegunn/vim-easy-align'
# vimpack install 'benmills/vimux'

# documentation
# vimpack install 'plasticboy/vim-markdown'
# vimpack install 'junegunn/goyo.vim'
# vimpack install 'vim-pandoc/vim-pandoc'
# vimpack install 'vim-pandoc/vim-pandoc-syntax'
# vimpack install 'reedes/vim-pencil'

# markdown
# vimpack install 'iamcco/markdown-preview.nvim'
# vimpack install 'suan/vim-instant-markdown'
# npm -g install instant-markdown-d
# pip install --user smdv

# diagrams
# vimpack install 'aklt/plantuml-syntax'
# vimpack install 'tyru/open-browser.vim'
# vimpack install 'weirongxu/plantuml-previewer.vim'

# dev related
vimpack install 'editorconfig/editorconfig-vim'
# vimpack install 'tpope/vim-fugitive'
# vimpack install 'tpope/vim-commentary'
vimpack install 'sheerun/vim-polyglot'
# vimpack install 'janko-m/vim-test'
# vimpack install 'dense-analysis/ale'

# language specific
# vimpack install 'cespare/vim-toml'
# vimpack install 'hail2u/vim-css3-syntax'
# vimpack install 'mxw/vim-jsx'
# vimpack install 'OrangeT/vim-csharp'
# vimpack install 'rust-lang/rust.vim'
# vimpack install 'tpope/vim-rails'
# vimpack install 'vim-ruby/vim-ruby'
# vimpack install 'pangloss/vim-javascript'

# coc
# vimpack install 'neoclide/coc.nvim' "$yarn_install"
# vimpack install 'neoclide/coc-css' "$yarn_install"
# vimpack install 'neoclide/coc-eslint' "$yarn_install"
# vimpack install 'amiralies/coc-flow' "$yarn_install"
# vimpack install 'neoclide/coc-emmet' "$yarn_install"
# vimpack install 'neoclide/coc-git' "$yarn_install"
# vimpack install 'neoclide/coc-html' "$yarn_install"
# vimpack install 'neoclide/coc-java' "$yarn_install"
# vimpack install 'neoclide/coc-jest' "$yarn_install"
# vimpack install 'neoclide/coc-json' "$yarn_install"
# vimpack install 'neoclide/coc-prettier' "$yarn_install"
# vimpack install 'neoclide/coc-python' "$yarn_install"
# vimpack install 'neoclide/coc-rls' "$yarn_install"
# vimpack install 'neoclide/coc-solargraph' "$yarn_install"
# vimpack install 'neoclide/coc-stylelint' "$yarn_install"
# vimpack install 'neoclide/coc-tsserver' "$yarn_install"
# vimpack install 'neoclide/coc-yaml' "$yarn_install"

# other
# vimpack install 'prettier/vim-prettier' "$yarn_install"
