#!/usr/bin/env sh
#
# Install homebrew brews
#

# common utilities
brew install 'curl'
brew install 'gcc'
brew install 'git'
brew install 'git-extras'
brew install 'ctags'
brew install 'httpie'
brew install 'imagemagick'
brew install 'jq'
brew install 'tmux'
brew install 'the_silver_searcher'
brew install 'vim'

# text utils (i.e. envsubst)
brew install gettext
brew link gettext --force
