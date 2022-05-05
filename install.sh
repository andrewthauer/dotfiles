#!/usr/bin/env bash
#
# Setup a brand new system
#

set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
DOTFILES_INSTALL_USE_SUDO="${DOTFILES_INSTALL_USE_SUDO:-0}"
# DOTFILES_INSTALL_USE_NIX_PKGS="${DOTFILES_INSTALL_USE_NIX_PKGS:-0}"
# DOTFILES_INSTALL_PACKAGE_MANAGER=

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
        $sudo_cmd apt install -y ${pkgs}
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

get_package_manager() {
  if [[ -n "$DOTFILES_INSTALL_PACKAGE_MANAGER" ]]; then
    echo "$DOTFILES_INSTALL_PACKAGE_MANAGER"
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

install_package_managers() {
  case ${os_family} in
    "macos")
      # Always install homebrew on macos
      "${DOTFILES_DIR}/modules/homebrew/install.sh"
      brew install $pkgs
      ;;
    *) ;;
  esac

  if [[ "${pkg_mgr}" == "nix" ]]; then
    "${DOTFILES_DIR}/modules/nix/install.sh"
  fi
}

install_packages() {
  local pkgs="$1"

  case ${pkg_mgr} in
    "apt") $sudo_cmd apt install -y $pkgs ;;
    "dnf") $sudo_cmd dnf install -y $pkgs ;;
    "yum") $sudo_cmd yum install -y $pkgs ;;
    "pacman") $sudo_cmd pacman -S $pkgs ;;
    "brew")
      source "${DOTFILES_DIR}/modules/homebrew/.config/profile.d/homebrew.sh"
      brew install $pkgs
      ;;
    "nix")
      source "${DOTFILES_DIR}/modules/nix/.config/profile.d/nix.sh"
      nix_pkgs=("$pkgs")
      # shellcheck disable=SC2068
      for pkg in ${nix_pkgs[@]}; do
        nix-env -iA nixpkgs."$pkg"
      done
      ;;
    *) ;;
  esac
}

install_prompt() {
  case ${pkg_mgr} in
    "apt") curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
    *) install_packages "starship" ;;
  esac
}

register_zsh_users_repo() {
  local plugin="$1"

  case ${pkg_mgr} in
    "apt")
      debian_ver="11"
      echo "deb http://download.opensuse.org/repositories/shells:/zsh-users:/$plugin/Debian_$debian_ver/ /" | $sudo_cmd tee /etc/apt/sources.list.d/shells:zsh-users:$plugin.list
      curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:$plugin/Debian_$debian_ver/Release.key | gpg --dearmor | $sudo_cmd tee /etc/apt/trusted.gpg.d/shells_zsh-users_$plugin.gpg >/dev/null
      $sudo_cmd apt update
      ;;
    *) ;;
  esac
}

install_zsh_plugins() {
  plugins=("zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search")

  for p in ${plugins[@]}; do
    register_zsh_users_repo $p
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

clone_dotfiles() {
  # Clone this repo
  if [[ ! -d "${DOTFILES_DIR}" ]]; then
    git clone "https://github.com/andrewthauer/dotfiles.git" ~/.dotfiles
  fi

  # Ensure repo is using the ssh remote
  pushd "${DOTFILES_DIR}" >/dev/null
  git remote set-url origin git@github.com:andrewthauer/dotfiles.git
  popd >/dev/null
}

setup_default_shells() {
  local bash_path
  bash_path="$(which bash | head -1)"
  local zsh_path
  zsh_path="$(which zsh | head -1)"

  if [[ "${os_family}" == "macos" ]]; then
    # Add available shells
    ! grep -q "${bash_path}" /etc/shells && echo "${bash_path}/bin/bash" | $sudo_cmd tee -a /etc/shells
    ! grep -q "${zsh_path}" /etc/shells && echo "${zsh_path}/bin/zsh" | $sudo_cmd tee -a /etc/shells
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
  clone_dotfiles
  # source "${DOTFILES_DIR}/modules/shell/.config/environment"

  # install packages
  install_package_managers
  install_packages "stow"
  install_packages "zsh"
  install_packages "fasd fzf neovim"
  install_zsh_plugins
  install_prompt

  # configure
  # setup_default_shells
  # backup_dotfiles
  make

  # Start zsh
  # echo "Starting zsh ..."
  # zsh
}

# Run the script
main "$@"
exit 0
