#!/usr/bin/env bash
# Summary:
#   Install & setup this dotfiles repo
#
# Usage:
#   ./install.sh
#
# Environmenet Variables:
#   DOTFILES_DIR                        The target directory for the dotfiles repo
#   DOTFILES_INSTALL_USE_SUDO           Use sudo or not
#                                         Options: 0 (no) or 1 (yes)
#   DOTFILES_PACKAGE_MANAGER            Preferred pacakge manager (defaults based on OS)
#                                         Options: brew | nix | apt | dnf | yum | pacman
#
# Examples:
#   ./install.sh
#   DOTFILES_DIR="$HOME/my-dotfiles" ./install.sh
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/main/install.sh)"

set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
DOTFILES_BIN="$DOTFILES_DIR/bin"
DOTFILES_INSTALL_USE_SUDO="${DOTFILES_INSTALL_USE_SUDO:-0}"

# Get the appropriate package manager script
# TODO: source /dev/stdin <<< "$(curl https://raw.github.com/andrewthauer/dotfiles/main/lib/os.sh)"
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

get_package_manager() {
  if [[ -n "$DOTFILES_PACKAGE_MANAGER" ]]; then
    echo "$DOTFILES_PACKAGE_MANAGER"
  else
    case ${os_family} in
      "macos") echo "brew" ;;
      "debian") echo "apt" ;;
      "fedora") echo "dnf" ;;
      "rhel") echo "yum" ;;
      "arch") echo "pacman" ;;
      *) ;;
    esac
  fi
}

install_prerequisites() {
  local pkgs="curl file git"

  case ${os_family} in
    "macos")
      if [[ ! -d "$(xcode-select -p)" ]]; then
        xcode-select --install
      else
        echo "xcode command line tools installed"
      fi
      ;;
    "debian")
      $sudo_cmd apt update &&
        $sudo_cmd apt install -y build-essential &&
        $sudo_cmd apt install -y "${pkgs}"
      ;;
    "fedora")
      $sudo_cmd dnf groupinstall "Development Tools" &&
        $sudo_cmd dnf install -y libxcrypt-compat util-linux-user "${pkgs}"
      ;;
    "rhel")
      $sudo_cmd yum groupinstall "Development Tools" &&
        $sudo_cmd yum install -y "${pkgs}"
      ;;
    "arch")
      echo "pacman"
      $sudo_cmd pacman -S base-devel "${pkgs}"
      ;;
    *)
      echo "OS family: '${os_family}' not supported"
      exit 1
      ;;
  esac
}

clone_dotfiles() {
  if [[ ! -d "${DOTFILES_DIR}" ]]; then
    # Clone this repo
    git clone "https://github.com/andrewthauer/dotfiles.git" ~/.dotfiles
  fi
}

install_package_manager() {
  case ${pkg_mgr} in
    "brew")
      # Always install homebrew on macos
      "${DOTFILES_DIR}/modules/homebrew/install.sh"
      # shellcheck disable=SC1091
      source "${DOTFILES_DIR}/modules/homebrew/.config/profile.d/homebrew.sh"
      ;;
    "nix")
      "${DOTFILES_DIR}/modules/nix/install.sh"
      ;;
    *) ;;
  esac
}

install_packages() {
  local pkg_cmd="$DOTFILES_BIN/pkg"
  local pkgs="$1"
  "$pkg_cmd" install "$pkgs"
}

install_prompt() {
  case ${pkg_mgr} in
    "apt") curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
    *) install_packages "starship" ;;
  esac
}

setup_dotfiles_core() {
  install_prompt
  install_packages zsh
  install_zsh_plugins

  # configure default shells
  "$DOTFILES_BIN/set-default-shells"

  # link dotfiles modules
  link_dotfile_modules
}

link_dotfile_modules() {
  local dotfiles_mod_cmd="$DOTFILES_BIN/dotfiles-module"

  # Link core dotfiles modules
  "$dotfiles_mod_cmd" add _stow _core git utility zsh

  # Link packager specific dotfiles
  case ${pkg_mgr} in
    "brew")
      "$dotfiles_mod_cmd" add homebrew
      ;;
    *) ;;
  esac
}

register_zsh_users_repo() {
  local plugin="$1"

  case ${pkg_mgr} in
    "apt")
      debian_ver="11"
      echo "deb http://download.opensuse.org/repositories/shells:/zsh-users:/$plugin/Debian_$debian_ver/ /" | $sudo_cmd tee "/etc/apt/sources.list.d/shells:zsh-users:$plugin.list"
      curl -fsSL "https://download.opensuse.org/repositories/shells:zsh-users:$plugin/Debian_$debian_ver/Release.key" | gpg --dearmor | "$sudo_cmd tee /etc/apt/trusted.gpg.d/shells_zsh-users_$plugin.gpg" >/dev/null
      $sudo_cmd apt update
      ;;
    *) ;;
  esac
}

install_zsh_plugins() {
  local plugins=("zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search")

  # shellcheck disable=SC2068
  for p in ${plugins[@]}; do
    register_zsh_users_repo "$p"
  done

  case ${pkg_mgr} in
    "apt")
      # TODO: Fix zsh-completions & zsh-history-substring-search on debian error even after registering
      plugins=("zsh-syntax-highlighting zsh-autosuggestions")
      ;;
    *) ;;
  esac

  install_packages "${plugins[@]}"
}

# shellcheck disable=SC2317
backup_dotfiles() {
  # Rename existing dotfiles
  local files=(~/.profile ~/.bash_profile ~/.bashrc ~/.zlogin ~/.zlogout ~/.zshenv ~/.zprofile ~/.zshrc)

  # move existing files
  for file in "${files[@]}"; do
    if [[ -f "${file}" && ! -L "${file}" ]]; then
      mv "${file}" "${file}.bak"
    fi
  done
}

main() {
  # Prompt for admin password upfront
  # sudo -v

  # sudo command
  sudo_cmd=""
  [[ "$DOTFILES_INSTALL_USE_SUDO" -eq 1 ]] && sudo_cmd="sudo "

  # get OS family & preferred package manager
  os_family="$(get_os_family)"
  pkg_mgr="$(get_package_manager)"

  # pre-setup steps
  install_prerequisites

  # clone the dotfiles (if needed)
  clone_dotfiles
  cd "$DOTFILES_DIR"

  # install core packages
  install_package_manager
  install_packages stow

  # setup base shell
  setup_dotfiles_core

  # configure dotfiles & shell
  # backup_dotfiles

  # TODO: Ensure repo is using the ssh remote
  # pushd "${DOTFILES_DIR}" >/dev/null
  # git remote set-url origin git@github.com:andrewthauer/dotfiles.git
  # popd >/dev/null
}

# Run the script
main "$@"
exit 0
