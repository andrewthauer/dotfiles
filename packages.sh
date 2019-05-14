#!/usr/bin/env bash
#
# Dotfiles package setup & config
#

# bash
dotfiles link ./modules/bash/.bash_profile ~/.bash_profile
dotfiles link ./modules/bash/.bashrc ~/.bashrc

# zsh
dotfiles install 'zsh-users/zsh-history-substring-search'
dotfiles install 'zsh-users/zsh-syntax-highlighting'
dotfiles link './modules/zsh/.zshenv' '~/.zshenv'
dotfiles link './modules/zsh/.zshrc' '~/.zshrc'

# zsh completions
dotfiles install 'docker/cli'
dotfiles install 'docker/compose'
dotfiles install 'zsh-users/zsh-completions'
dotfiles install 'lukechilds/zsh-better-npm-completion'
dotfiles link ./repos/docker/cli/contrib/completion/zsh/_docker ./zfunctions/_docker
dotfiles link ./repos/docker/compose/contrib/completion/zsh/_docker-compose ./zfunctions/_docker-compose
dotfiles link ./modules/rust/completion/_rustup ./zfunctions/_rustup

# zsh prompt
dotfiles install 'sindresorhus/pure'
dotfiles link ./repos/sindresorhus/pure/pure.zsh ./zfunctions/prompt_pure_setup
dotfiles link ./repos/sindresorhus/pure/async.zsh ./zfunctions/async

# git
dotfiles link ./modules/git/.gitignore_global ~/.gitignore
dotfiles link ./modules/git/.gitconfig ~/.gitconfig

# misc
dotfiles link ./modules/brew/Brewfile ~/.Brewfile
dotfiles link ./modules/hammerspoon ~/.hammerspoon
# dotfiles link ./modules/dotfiles/doc/man/man1/dotfiles.1 /usr/local/share/man/man1/dotfiles.1

# vim
dotfiles install 'editorconfig/editorconfig-vim'
dotfiles install 'vim-scripts/Zenburn'
dotfiles install 'sheerun/vim-polyglot'
dotfiles install 'junegunn/fzf'
dotfiles install 'neoclide/coc.nvim' --post-install "yarn install --frozen-lockfile"
dotfiles link ./modules/vim ~/.vim
dotfiles link ./modules/vim/.vimrc ~/.vimrc
dotfiles link ./modules/vim ~/.config/nvim
dotfiles link ./modules/vim/.vimrc ~/.config/nvim/init.vim
dotfiles link /usr/local/bin/vim /usr/local/bin/vi
