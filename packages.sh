#!/usr/bin/env bash
#
# Dotfiles package setup & config
#

# bash
symlink './modules/bash/.bash_profile' '~/.bash_profile'
symlink './modules/bash/.bashrc' '~/.bashrc'

# zsh
github install 'zsh-users/zsh-history-substring-search'
github install 'zsh-users/zsh-syntax-highlighting'
symlink './modules/zsh/.zshenv' '~/.zshenv'
symlink './modules/zsh/.zshrc' '~/.zshrc'

# zsh completions
github install 'docker/cli'
github install 'docker/compose'
github install 'zsh-users/zsh-completions'
github install 'lukechilds/zsh-better-npm-completion'
symlink './repos/docker/cli/contrib/completion/zsh/_docker' './zfunctions/_docker'
symlink './repos/docker/compose/contrib/completion/zsh/_docker-compose' './zfunctions/_docker-compose'
symlink './modules/rust/completion/_rustup' './zfunctions/_rustup'

# zsh prompt
github install 'sindresorhus/pure'
symlink './repos/sindresorhus/pure/pure.zsh' './zfunctions/prompt_pure_setup'
symlink './repos/sindresorhus/pure/async.zsh' './zfunctions/async'

# git
symlink './modules/git/.gitignore_global' '~/.gitignore'
symlink './modules/git/.gitconfig' '~/.gitconfig'

# misc
symlink './modules/brew/Brewfile' '~/.Brewfile'
symlink './modules/hammerspoon' '~/.hammerspoon'

# vim
github install 'editorconfig/editorconfig-vim'
github install 'vim-scripts/Zenburn'
github install 'sheerun/vim-polyglot'
github install 'junegunn/fzf'
github install 'neoclide/coc.nvim' --post-install "yarn install --frozen-lockfile"
symlink './modules/vim' '~/.vim'
symlink './modules/vim/.vimrc' '~/.vimrc'
symlink './modules/vim' '~/.config/nvim'
symlink './modules/vim/.vimrc' '~/.config/nvim/init.vim'
symlink '/usr/local/bin/vim' '/usr/local/bin/vi'
