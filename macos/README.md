macOS
=====

Machine Setup
-------------

### Bootrap

```shell
# Install command line tools
xcode-select --install

# Switch to use z-shell
$ chsh -s $(which zsh)

# Show all filename extensions and hiddle files by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
killall finder
```

### Install Homebrew

```shell
# Take ownership of /usr/local
sudo chown -R "$USER":admin /usr/local

# Download and install homebrew
curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
```

### Create SSH Key

```shell
SSH_KEY_NAME=id_rsa && \
  mkdir -p ~/.ssh && \
  if [ -e ~/.ssh/$SSH_KEY_NAME ]; then echo "$HOME/.ssh/${SSH_KEY_NAME} already exists"; return; fi && \
  printf "Enter your email: " && read EMAIL && \
  ssh-keygen -t rsa -b 4096 -C $EMAIL -f "$HOME/.ssh/$SSH_KEY_NAME" && \
  eval "$(ssh-agent -s)" && ssh-add -K "$HOME/.ssh/$SSH_KEY_NAME" && \
  pbcopy < "$HOME/.ssh/$SSH_KEY_NAME.pub" && \
  echo "Copied public key to clipboard"
```

[Add SSH Key to your account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account)

### Setup GitHub

```shell
echo "Setting up git ..." && \
  printf "Enter your Git user.name (e.g. John Smith): " && read GIT_USER_NAME && \
  printf "Enter your GitHub username (e.g. batman42): " && read GITHUB_USER && \
  git config --global user.name "$GIT_USER_NAME" && \
  git config --global user.email "$GITHUB_USER@users.noreply.github.com" && \
  git config --global core.excludesfile ~/.gitignore
```

### Clone Repo

```shell
DOTFILES_DIR=~/path/to/dotfiles && \
  git clone git@github.com:andrewthauer/dotfiles.git "$DOTFILES_DIR" &&
  ln -s ${DOTFILES_DIR} ${HOME}/.dotfiles}
```

### Run Setup

```shell
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}" && \
  ${DOTFILES_DIR}/macos/setup/_run
```
