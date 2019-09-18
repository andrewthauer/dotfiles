#!/usr/bin/env ruby
#
# Homebrew Bundle file
# - https://github.com/Homebrew/homebrew-bundle
#

# Common
brew 'ag'
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
brew 'jq'
brew 'make'
brew 'neovim'
brew 'openssl'
brew 'openvpn'
brew 'pandoc'
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

# Docker completion
brew 'docker-completion'
# brew 'docker-compose-completion'

# Node (nodenv) plugins - https://github.com/nodenv/nodenv/wiki/Plugins
# brew 'node', link: false
brew 'node-build' # used by nodenv
brew 'yarn'
brew 'nodenv'
tap 'nodenv/nodenv'
brew 'nodenv/nodenv/nodenv-aliases'
# brew 'nodenv/nodenv/nodenv-default-packages'
brew 'nodenv/nodenv/nodenv-package-json-engine'
brew 'nodenv/nodenv/nodenv-package-rehash'
tap 'ouchxp/nodenv'
brew 'ouchxp/nodenv/nodenv-nvmrc'

# Python (pyenv)
# tap 'jawshooah/pyenv'
brew 'pyenv'
# brew 'python', link: false

# Redis
tap 'ringohub/redis-cli'
brew 'redis-cli'

# Ruby (rbenv)
# brew 'ruby', link: false
brew 'ruby-build' # used by rbenv
brew 'rbenv'
# brew 'rbenv-default-gems'

# Local Brewfile
local_brewfile = File.expand_path('~/.Brewfile.local')
instance_eval File.read(local_brewfile) if File.exists?(local_brewfile)

#
# Only macOS beyond here
#

require 'os'
return unless OS.mac?

# macOS specific taps
tap 'homebrew/cask'
tap 'homebrew/cask-versions'
tap 'homebrew/cask-fonts'
tap 'homebrew/services'

# Caskroom apps
cask 'dash'
cask 'docker'
cask 'homebrew/cask-versions/firefox-developer-edition'
cask 'google-chrome'
cask 'hammerspoon'
cask 'karabiner-elements'
cask 'slack'
cask 'spotify'
cask 'visual-studio-code'

# Caskroom fonts
tap 'homebrew/cask-fonts'
cask 'homebrew/cask-fonts/font-fira-code'
