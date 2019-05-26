#!/usr/bin/env bash
#
# Dotfiles package setup & config
#

set -e

abs_dirname() {
  local path="$(realpath "$1")"
  echo "${path%/*}"
}

CURRENT_DIR="$(cd $(abs_dirname "$0"); pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
LOCAL_SETUP_SCRIPT="${DOTFILES_DIR}/local/setup.sh"

PATH="${PATH}:${DOTFILES_DIR}/bin"

check_if_sourced() {
  # Try to execute a `return` statement,
  # but do it in a sub-shell and catch the results.
  # If this script isn't sourced, that will raise an error.
  $(return >/dev/null 2>&1)

  # This script is not sourced
  if [ ! "$?" -eq "0" ]; then
    IS_SOURCED=1
  fi
}

ensure_directories() {
  mkdir -p "${DOTFILES_DIR}/local"
  mkdir -p "${DOTFILES_DIR}/repos"
  mkdir -p "${DOTFILES_DIR}/zfunctions"
}

setup_root_dir() {
  # Ensure the dotfiles home symlink is created and valid
  if [[ -d "${DOTFILES_DIR}" ]] && [[ ! -L "${DOTFILES_DIR}" ]]; then
    echo >&2 "Error: Dotfiles home is a real directory"
    exit 1
  elif [[ ! -L "${DOTFILES_DIR}" ]]; then
    echo "Creating dotfiles home symlink: ${DOTFILES_DIR} -> ${CURRENT_DIR}"
    ln -s "${CURRENT_DIR}" "${DOTFILES_DIR}"
  elif [[ ! -d "$(readlink "${DOTFILES_DIR}")" ]]; then
    echo "Replacing dotfiles home symlink: ${DOTFILES_DIR} -> ${CURRENT_DIR}"
    rm ${DOTFILES_DIR}
    ln -s "${CURRENT_DIR}" "${DOTFILES_DIR}"
  else
    echo "Dotfiles home is valid: ${DOTFILES_DIR} -> ${CURRENT_DIR}"
  fi
}

setup_base_modules() {
  # bash
  symlink './modules/bash/.bash_profile' '~/.bash_profile'
  symlink './modules/bash/.bashrc' '~/.bashrc'

  # docker completions
  github install 'docker/cli'
  github install 'docker/compose'
  symlink './repos/docker/cli/contrib/completion/zsh/_docker' './zfunctions/_docker'
  symlink './repos/docker/compose/contrib/completion/zsh/_docker-compose' './zfunctions/_docker-compose'

  # git
  symlink './modules/git/.gitignore_global' '~/.gitignore'
  symlink './modules/git/.gitconfig' '~/.gitconfig'

  # hammerspoon
  symlink './modules/hammerspoon' '~/.hammerspoon'

  # homebrew
  symlink './modules/brew/Brewfile' '~/.Brewfile'

  # vim
  "${DOTFILES_DIR}/modules/vim/setup.sh" $@

  # zsh
  github install 'zsh-users/zsh-history-substring-search'
  github install 'zsh-users/zsh-syntax-highlighting'
  symlink './modules/zsh/.zshenv' '~/.zshenv'
  symlink './modules/zsh/.zshrc' '~/.zshrc'

  # zsh completions
  github install 'zsh-users/zsh-completions'
  github install 'lukechilds/zsh-better-npm-completion'
  symlink './modules/rust/completion/_rustup' './zfunctions/_rustup'

  # zsh prompt
  github install 'sindresorhus/pure'
  symlink './repos/sindresorhus/pure/pure.zsh' './zfunctions/prompt_pure_setup'
  symlink './repos/sindresorhus/pure/async.zsh' './zfunctions/async'
}

run_base_setup() {
  setup_root_dir
  ensure_directories
  setup_base_modules
}

setup_exec() {
  check_if_sourced

  # Run the local setup if this file wasn't sourced (by local) and there is a
  # local file. This allows the local file to run this script by sourcing.
  if [[ ! -z ${IS_SOURCED} && -e "${LOCAL_SETUP_SCRIPT}" ]]; then
    echo "Running local setup -> '${LOCAL_SETUP_SCRIPT}'"
    pushd ${DOTFILES_DIR} >/dev/null
    ${LOCAL_SETUP_SCRIPT}
    popd >/dev/null
  else
    echo "Running base setup"
    run_base_setup
  fi
}

setup_exec
exit 0
