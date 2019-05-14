#!/usr/bin/env bash

# zsh
github-repo 'zsh-users/zsh-history-substring-search'
github-repo 'zsh-users/zsh-syntax-highlighting'

# zsh completions
github-repo 'docker/cli'
github-repo 'docker/compose'
github-repo 'zsh-users/zsh-completions'
github-repo 'lukechilds/zsh-better-npm-completion'

# zsh prompt
github-repo 'sindresorhus/pure'

# vim
github-repo 'editorconfig/editorconfig-vim'
github-repo 'vim-scripts/Zenburn'
github-repo 'sheerun/vim-polyglot'
github-repo 'junegunn/fzf'
github-repo 'neoclide/coc.nvim' --post-install "yarn install --frozen-lockfile"
