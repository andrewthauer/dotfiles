#!/usr/bin/env bash
#
# Setup a brand new system
#

set -e

# source /dev/stdin <<< "$(curl https://raw.github.com/andrewthauer/dotfiles/master/lib/os.sh)"

# Get the appropriate package manager script
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
  for kv in ${os_info[@]}; do
    key="${kv%%::*}"
    val="${kv##*::}"
    [[ -f "$key" ]] && os_family="${val}"
  done
  echo "${os_family}"
}

package_mgr_cmd() {
  os_family="$(get_os_family)"

  case ${os_family} in
    "macos")    cmd="brew install" ;;
    "debian")   cmd="sudo apt-get install -y" ;;
    "fedora")   cmd="sudo dnf install -y" ;;
    "rhel")     cmd="sudo yum install -y" ;;
    "arch")     cmd="sudo pacman -S" ;;
    *)          cmd="" ;;
  esac

  echo "${cmd}"
}

install_prerequisites() {
  os_family=$(get_os_family)
  packages="curl file git"

  if [[ "${os_family}" == "macos" ]]; then
    if [[ ! -d "$(xcode-select -p)" ]]; then
      xcode-select --install
    else
      echo "xcode command line tools installed"
    fi
  elif [[ "${os_family}" == "debian" ]]; then
    sudo apt-get update && sudo apt-get install -y build-essential ${packages}
  elif [[ "${os_family}" == "fedora" ]]; then
    sudo dnf groupinstall "Development Tools" && sudo dnf install -y libxcrypt-compat ${packages}
  elif [[ "${os_family}" == "rhel" ]]; then
    sudo yum groupinstall "Development Tools" && sudo yum install -y ${packages}
  elif [[ "${os_family}" == "arch" ]]; then
    sudo pacman -S base-devel ${packages}
  else
    echo "OS family: '${os_family}' not supported"
    exit 1
  fi
}

install_brew() {
  echo "Do you want to install homebrew [y/N]?"
  read answer
  case "${answer}" in [yY]|[yY][eE][sS])
    # Install homebrew & default dependencies
    ${DOTFILES_DIR}/homebrew/install.sh
  esac
}

install_dotfiles_deps() {
  packages="bash fasd make neovim stow zsh"
  pkg_mgr_cmd="$(package_mgr_cmd)"
  ${pkg_mgr_cmd} ${packages}
}

clone_dotfiles() {
  # Clone this repo
  if [[ ! -d "${DOTFILES_DIR}" ]]; then
    git clone "https://github.com/andrewthauer/dotfiles.git" ~/.dotfiles
  fi
}

setup_zsh() {
  # Use brew or fallback to native
  BIN_PREFIX="$(brew --prefix)"
  if [[ -z "${BIN_PREFIX}" ]]; then
    BIN_PREFIX="/usr"
  fi

  # Add availble shells
  [[ ! $(grep "${BIN_PREFIX}/bin/bash" /etc/shells) ]] && echo "${BIN_PREFIX}/bin/bash" | sudo tee -a /etc/shells
  [[ ! $(grep "${BIN_PREFIX}/bin/zsh" /etc/shells) ]] && echo "${BIN_PREFIX}/bin/zsh" | sudo tee -a /etc/shells

  # Change default shell to zsh
  if [[ "${SHELL}" != "${BIN_PREFIX}/bin/zsh" ]]; then
    sudo chsh -s "${BIN_PREFIX}/bin/zsh"
  fi
}

setup_dotfiles() {
  # Rename existing dotfiles
  files=(~/.profile ~/.bash_profile ~/.bashrc ~/.zlogin ~/.zlogout ~/.zshenv ~/.zprofile ~/.zshrc)
  for file in ${files[@]}; do
    if [[ -f ${file} && ! -L "${file}" ]]; then
      mv "${file}" "${file}.bak"
    fi
  done

  # Setup the dotfiles
  pushd ${DOTFILES_DIR} > /dev/null
  make
  popd > /dev/null
}

system_specific_setup() {
  os_family="$(get_os_family)"
  makefile="${DOTFILES_DIR}/@${os_family}"

  # Execute system specific makefile if it exists
  if [[ -d "${makefile}" ]]; then
    make -C "${makefile}"
  fi
}

main() {
  # Prompt for admin password upfront
  sudo -v

  # Install
  install_prerequisites
  clone_dotfiles
  install_brew
  install_dotfiles_deps
  setup_zsh
  setup_dotfiles
  system_specific_setup

  # Start zsh
  # echo "Starting zsh ..."
  # zsh
}

# Set the target directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Run the script
main "$@"
exit 0
