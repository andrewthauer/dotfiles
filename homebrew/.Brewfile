#!/usr/bin/env ruby
#
# Homebrew Bundle file
# - https://github.com/Homebrew/homebrew-bundle
#

# Brews
brew 'aspell'
brew 'autoconf'
brew 'automake'
brew 'bash'
brew 'bash-completion'
brew 'cmake'
brew 'coreutils'
brew 'curl'
brew 'fasd'
brew 'gcc'
brew 'gettext', link: true
brew 'git'
brew 'gpg'
brew 'make'
brew 'neovim'
brew 'openssl'
brew 'pkg-config'
brew 'readline'
brew 'stow'
brew 'tmux'
brew 'tree'
brew 'vcprompt'
brew 'zsh'
brew 'zsh-autosuggestions'
brew 'zsh-completions'
brew 'zsh-history-substring-search'
brew 'zsh-syntax-highlighting'

# Local Brewfile
local_brewfile = File.expand_path('~/.Brewfile.local')
instance_eval File.read(local_brewfile) if File.exists?(local_brewfile)
