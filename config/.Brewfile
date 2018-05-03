#!/usr/bin/env ruby
#
# Homebrew Bundle file
# - https://github.com/Homebrew/homebrew-bundle
#

# https://github.com/Homebrew/homebrew-services
tap 'homebrew/services'

# Brews
brew 'autoconf'
brew 'automake'
brew 'awscli'
brew 'bash'
brew 'bashdb'
brew 'bats'
brew 'coreutils'
brew 'curl'
brew 'fasd'
brew 'gcc'
brew 'gettext', link: true
brew 'git'
brew 'git-extras'
brew 'gpg'
brew 'httpie'
brew 'imagemagick'
brew 'jq'
brew 'lesspipe'
brew 'libtool'
brew 'libxml2'
brew 'libxslt'
brew 'libyaml'
brew 'neovim'
brew 'nodenv'
brew 'openssl'
brew 'openvpn'
brew 'pandoc'
brew 'pkg-config'
brew 'readline'
brew 'shellcheck'
brew 'syncthing'
brew 'tmux'
brew 'tree'
brew 'unixodbc'
brew 'vim', args: ['without-python']
brew 'yarn', args: ['without-node']
brew 'zsh'

# caskroom
tap 'caskroom/cask'
cask 'beyond-compare'
cask 'dash'
cask 'docker'
cask 'electrum'
cask 'google-chrome'
cask 'hammerspoon'
cask 'iterm2'
cask 'kap'
cask 'keepassxc'
cask 'osxfuse'
cask 'ngrok'
cask 'postman'
cask 'powershell'
cask 'sketch'
cask 'slack'
cask 'spotify'
cask 'the-unarchiver'
cask 'teamsql'
cask 'typora'
cask 'veracrypt'
cask 'visual-studio-code'
cask 'vmware-fusion'

# caskroom/versions
cask 'caskroom/versions/firefox-developer-edition'
cask 'caskroom/versions/visual-studio-code-insiders'

# caskroom/fonts
cask 'caskroom/fonts/font-roboto'
cask 'caskroom/fonts/font-open-sans'

# caskroom drivers
cask 'chromedriver'

# Local Brewfile
local_brewfile = File.expand_path('~/.Brewfile.local')
instance_eval File.read(local_brewfile) if File.exists?(local_brewfile)
