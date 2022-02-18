#!/usr/bin/env bash
#
# Setup a brand new system
#

set -e

# should we use nix package manager
USE_NIX_PKGS="${USE_NIX_PKGS:-}"

# Get the appropriate package manager script
# TODO: source /dev/stdin <<< "$(curl https://raw.github.com/andrewthauer/dotfiles/master/lib/os.sh)"
get_os_family() {
  # ideally we would use an associative array here
  # but this needs to work in bash < v4 for macos
  os_info=(
    "/etc/auto_master::macos"
    "/etc/debian_version::debian"
    "/etc/fedora-release::fedora"
    "/etc/redhat-release::rhel"
    "/etc/arch-release::arch"
    "/etc/alpine-release::alpine"
  )
  for kv in "${os_info[@]}"; do
    key="${kv%%::*}"
    val="${kv##*::}"
    [[ -f "$key" ]] && os_family="${val}"
  done
  echo "${os_family}"
}

install_prerequisites() {
  local pkgs="curl file git"

  if [[ "${os_family}" == "macos" ]]; then
    if [[ ! -d "$(xcode-select -p)" ]]; then
      xcode-select --install
    else
      echo "xcode command line tools installed"
    fi
  elif [[ "${os_family}" == "debian" ]]; then
    sudo apt-get update && sudo apt-get install -y build-essential "${pkgs}"
  elif [[ "${os_family}" == "fedora" ]]; then
    sudo dnf groupinstall "Development Tools" && sudo dnf install -y libxcrypt-compat util-linux-user "${pkgs}"
  elif [[ "${os_family}" == "rhel" ]]; then
    sudo yum groupinstall "Development Tools" && sudo yum install -y "${pkgs}"
  elif [[ "${os_family}" == "arch" ]]; then
    sudo pacman -S base-devel "${pkgs}"
  else
    echo "OS family: '${os_family}' not supported"
    exit 1
  fi
}

install_packages() {
  local pkgs="$1"

  if [[ -n "$USE_NIX_PKGS" ]]; then
    nix_pkgs=("$pkgs")
    # shellcheck disable=SC2068
    for pkg in ${nix_pkgs[@]}; do
      nix-env -iA nixpkgs."$pkg"
    done
  else
    case ${os_family} in
      "macos")
        use_homebrew && brew install "$pkgs"
        ;;
      "debian") sudo apt-get install -y "$pkgs" ;;
      "fedora") sudo dnf install -y "$pkgs" ;;
      "rhel") sudo yum install -y "$pkgs" ;;
      "arch") sudo pacman -S "$pkgs" ;;
      *) ;;
    esac
  fi
}

install_package_managers() {
  printf "Do you want to install nix [y/N]? "
  read -r answer
  case "${answer}" in [yY] | [yY][eE][sS])
    "${DOTFILES_DIR}/nix/install.sh"
    ;;
  esac

  printf "Do you want to install homebrew [y/N]? "
  read -r answer
  case "${answer}" in [yY] | [yY][eE][sS])
    "${DOTFILES_DIR}/homebrew/install.sh"
    ;;
  esac
}

use_homebrew() {
  source "${DOTFILES_DIR}/homebrew/.config/profile.d/homebrew.sh"
}

clone_dotfiles() {
  # Clone this repo
  if [[ ! -d "${DOTFILES_DIR}" ]]; then
    git clone "https://github.com/andrewthauer/dotfiles.git" ~/.dotfiles
  fi
}

source_environment() {
  source "${DOTFILES_DIR}/shell/.config/environment"
}

setup_default_shells() {
  local bash_path
  bash_path="$(which bash | head -1)"
  local zsh_path
  zsh_path="$(which zsh | head -1)"

  if [[ "${os_family}" == "macos" ]]; then
    # Add availble shells
    ! grep -q "${bash_path}" /etc/shells && echo "${bash_path}/bin/bash" | sudo tee -a /etc/shells
    ! grep -q "${zsh_path}" /etc/shells && echo "${zsh_path}/bin/zsh" | sudo tee -a /etc/shells
  fi

  # Change default shell to zsh
  chsh -s "$zsh_path"
}

backup_dotfiles() {
  # Rename existing dotfiles
  files=(~/.profile ~/.bash_profile ~/.bashrc ~/.zlogin ~/.zlogout ~/.zshenv ~/.zprofile ~/.zshrc)
  for file in "${files[@]}"; do
    if [[ -f "${file}" && ! -L "${file}" ]]; then
      mv "${file}" "${file}.bak"
    fi
  done
}

update_git_remote() {
  pushd "${DOTFILES_DIR}" >/dev/null
  git remote set-url origin git@github.com:andrewthauer/dotfiles.git
  popd >/dev/null
}

stow_packages() {
  source_environment

  echo "Creating required directories"
  mkdir -p "${XDG_CONFIG_HOME}"/{profile.d,shell.d}
  mkdir -p "${XDG_CONFIG_HOME}"/{git,less,hammerspoon,homebrew}
  mkdir -p "${HOME}"/.ssh/config.d
  mkdir -p "${XDG_CACHE_HOME}"/less
  mkdir -p "${XDG_BIN_HOME}"

  pushd "${DOTFILES_DIR}" >/dev/null
  mkdir -p "local"
  echo "Stow core dotfiles packages"
  stow -t ~ asdf bash fasd fzf git shell tmux vim zsh
  popd >/dev/null
}

main() {
  # Prompt for admin password upfront
  sudo -v

  # get OS family
  os_family="$(get_os_family)"

  # Install
  install_prerequisites
  clone_dotfiles
  source_environment
  install_package_managers
  install_packages "stow bash zsh"
  setup_default_shells
  backup_dotfiles
  update_git_remote
  stow_packages

  # Start zsh
  # echo "Starting zsh ..."
  # zsh
}

# Set the target directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Run the script
main "$@"
exit 0
