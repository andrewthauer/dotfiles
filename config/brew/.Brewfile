#!/usr/bin/env ruby
#
# Homebrew Bundle file
# - https://github.com/Homebrew/homebrew-bundle
#

# Taps
tap 'homebrew/services' # https://github.com/Homebrew/homebrew-services

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
brew 'hub'
brew 'httpie'
brew 'imagemagick'
brew 'jq'
brew 'lesspipe'
brew 'libtool'
brew 'libxml2'
brew 'libxslt'
brew 'libyaml'
brew 'neovim'
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
tap 'homebrew/cask'
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
cask 'powershell'
cask 'sketch'
cask 'slack'
cask 'spotify'
cask 'teamsql'
cask 'the-unarchiver'
cask 'typora'
cask 'veracrypt'
cask 'visual-studio-code'

# caskroom drivers
cask 'chromedriver'

# caskroom/versions
tap 'homebrew/cask-versions'
cask 'homebrew/cask-versions/firefox-developer-edition'
cask 'homebrew/cask-versions/visual-studio-code-insiders'

# caskroom/fonts
tap 'homebrew/cask-fonts'
cask 'homebrew/cask-fonts/font-fira-code'
cask 'homebrew/cask-fonts/font-roboto'
cask 'homebrew/cask-fonts/font-open-sans'

# Local Brewfile
local_brewfile = File.expand_path('~/.Brewfile.local')
instance_eval File.read(local_brewfile) if File.exists?(local_brewfile)
