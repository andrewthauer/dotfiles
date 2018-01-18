# macOS

> Setup a new macOS machine.

## Zsh

Change your default shell to `Zsh`

```sh
chsh -s $(which zsh)
```

## Homebrew

```shell
# Take owernship of /usr/local
sudo chown -R "$USER":admin /usr/local

# Download and install homebrew
curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby \
  brew tap homebrew/services \
  brew tap caskroom/cask \
  brew tap caskroom/versions \
  brew tap caskroom/fonts

# Install common brew packages
brew install git
brew install zsh
```

## Create SSH Key

```shell
SSH_KEY_NAME="id_rsa" && \
  mkdir -p ~/.ssh && \
  if [ -e ~/.ssh/$SSH_KEY_NAME ]; then echo "$HOME/.ssh/${SSH_KEY_NAME} already exists"; return; fi && \
  printf "Enter your email: " && read EMAIL && \
  ssh-keygen -t rsa -b 4096 -C $EMAIL -f "$HOME/.ssh/$SSH_KEY_NAME" && \
  eval "$(ssh-agent -s)" && ssh-add -K "$HOME/.ssh/$SSH_KEY_NAME" && \
  pbcopy < "$HOME/.ssh/$SSH_KEY_NAME.pub" && \
  echo "Copied public key to clipboard"
```

[Add SSH Key to your account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account)

## Setup GitHub

```shell
echo "Setting up git ..." && \
  printf "Enter your Git user.name (e.g. John Smith): " && read GIT_USER_NAME && \
  printf "Enter your GitHub username (e.g. batman42): " && read GITHUB_USER && \
  git config --global user.name "$GIT_USER_NAME" && \
  git config --global user.email "$GITHUB_USER@users.noreply.github.com"
```

## Install Dotfiles

See [README](../readme.md#setup)

## macOS Defaults

```shell
# Optional - Run setup scripts
${DOTFILES_DIR}/macos/setup/defaults.sh
```
