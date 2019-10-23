#/usr/bin/env bash
# =============================================================================
# NOTES:
# - dump load gnome terminal settings
#     https://gist.github.com/reavon/0bbe99150810baa5623e5f601aa93afc
# =============================================================================

# Prompt for admin password upfront
sudo -v

#
# Base system setup
#

# Remove annoying command not found package
sudo dnf remove PackageKit-command-not-found

# sudo dnf instal util-linux-user

#
# Core packages
#

# Pre-requisites
sudo dnf groupinstall "Development Tools"
sudo dnf install -y \
  libxcrypt-compat \
  util-linux-user \
  curl \
  file \
  git \
  make \
  stow

# Bash
sudo dnf install -y bash

# vcprompt
curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > "${HOME}/.local/bin/vcprompt"
chmod 755 "${HOME}/.local/bin/vcprompt"

# Zsh
sudo dnf install -y zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${XDG_DATA_HOME}/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-history-substring-search "${XDG_DATA_HOME}/zsh-history-substring-search"
git clone https://github.com/zsh-users/zsh-autosuggestions "${XDG_DATA_HOME}/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-completions "${XDG_DATA_HOME}/zsh-completions"

# Install base packages
sudo dnf install -y \
  make \
  neovim \
  stow \
  tmux

# Install fasd
git clone https://github.com/clvv/fasd "${XDG_DATA_HOME}/fasd"
pushd "${XDG_DATA_HOME}/fasd" > /dev/null
sudo make install
popd > /dev/null

#
# Node.js
#

# Install nodenv
NODENV_ROOT="${XDG_DATA_HOME}/nodenv"
git clone https://github.com/nodenv/nodenv.git "${NODENV_ROOT}"
NODENV_PLUGINS="${NODENV_ROOT}/plugins"
mkdir -p "${NODENV_PLUGINS}"
git clone https://github.com/nodenv/node-build.git "${NODENV_PLUGINS}/node-build"

# Install yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo dnf install -y yarn

#
# Global node pckages
#

# Set yarn global prefix == ~/.local/bin
yarn config set prefix "${HOME}/.local"

yarn global add git-open
# yarn global add

#
# Docker
#

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli docker-compose containerd.io
# sudo systemctl start docker
# sudo docker run hello-world

#
# Applications
#

# Install firefox developer edition
./install-firefox.sh

# Install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
# via flatpak
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# flatpak install flathub com.visualstudio.code

#
# Other system settings
#

# Install fira-code font
sudo dnf copr enable evana/fira-code-fonts
sudo dnf install fira-code-fonts
