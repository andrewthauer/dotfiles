# macOS

> Setup a new macOS machine.

## Setup

### Basebones Setup

Setup an SSH Key

```shell
# This will create an `id_rsa` key in the `~/.ssh` directory
SSH_KEY_NAME="id_rsa" sh <(curl -fsS 'https://raw.githubusercontent.com/andrewthauer/dotfiles/master/bin/ssh-key-gen')
```

Now [Add the SSH Key to your GitHub account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account).

Some basic macOS settings to get started

```shell
# Show all hidden files (rc, dotfiles, etc.)
defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder

# Install macOS Command Line Tools
xcode-select --install

# Change your default shell to zsh
chsh -s $(which zsh)
```

Setup Homebrew

```shell
# Intall homebrew
curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
brew tap caskroom/cask && brew tap caskroom/versions
```

Install `realpath`

```shell
# The `realpath` command is currently required for the dotfiles commands
brew install coreutils
```

### Setup Dotfiles

```shell
git clone git@github.com:andrewthauer/dotfiles.git
cd dotfiles
./bin/dotfiles setup
```

**NOTE: You many need to run `dotfiles setup` a second time after you restart your shell**

### macOS Settings

```shell
# macOS default settings
${DOTFILES_DIR}/system/macos/set-defaults.sh

# Set HostName, LocalHostName & ComputerName
${DOTFILES_DIR}/system/macos/set-hostname.sh "my-host-name"
```

### Install Homebrew

```shell
${DOTFILES_DIR}/system/macos/install-brew.sh
```
