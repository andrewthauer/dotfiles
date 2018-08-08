#
# Node.js environment initialization
#

no_rehash_arg="--no-rehash"

# Use anyenv / nodenv if available
if [[ -x "$(command -v anyenv)" && -d "$(anyenv root)/envs/nodenv" ]]; then
  # Skip

# Use asdf if available and plugin is installed
elif [[ -x "$(command -v asdf)" && -d "${ASDF_DIR}/plugins/nodejs" ]]; then
  ASDF_NODEJS=

# Load custom installed nodenv
elif [[ ! -z "${NODENV_ROOT}" && -s "${NODENV_ROOT}/bin/nodenv" ]]; then
  export PATH="${NODENV_ROOT}/bin:${PATH}"
  eval "$(nodenv init - ${no_rehash_arg})"

# Load manually installed nodenv
elif [[ -s "${HOME}/.nodenv/bin/nodenv" ]]; then
  export PATH="${HOME}/.nodenv/bin:${PATH}"
  eval "$(nodenv init - ${no_rehash_arg})"

# Load package manager installed nodenv
elif [[ -x "$(command -v nodenv)" ]]; then
  eval "$(nodenv init - ${no_rehash_arg})"

# Load custom installed NVM
elif [[ ! -z "${NVM_DIR}" && -s "${NVM_DIR}/nvm.sh)" ]]; then
  source "${NVM_DIR}/nvm.sh"
  [[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"

# Load manually installed NVM
elif [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  NVM_DIR="${HOME}/.nvm"
  source "${NVM_DIR}/.nvm/nvm.sh"
  [[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"

# Load package manager installed NVM
elif [[ -x "$(command brew)" && -d "$(brew --prefix nvm 2> /dev/null)" ]]; then
  NVM_DIR="$(brew --prefix nvm)"
  source "${NVM_DIR}/.nvm/nvm.sh"
  [[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"

# Return if requirements are not found
elif [[ ! -x "$(command -v node)" ]]; then
  return 1
fi

# Additonal NVM support
if [[ ! -z "${NVM_DIR}" ]]; then
  # zsh-nvm plugin (https://github.com/lukechilds/zsh-nvm)
  export NVM_AUTO_USE=true  # Automatically use .nvmrc

  # Enable lazy loading (when NOT inside vscode)
  [[ -z "$VSCODE_PID" ]] && export NVM_LAZY_LOAD=true
fi

# Yarn support
if [[ -d "${HOME}/.yarn" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi

#
# Aliases & helpers
#

npm-exec() {
  "./node_modules/.bin/$1" ${@:2}
}

# npm
alias npme="npm-exec"

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"

# nodenv
alias nenv="nodenv"
alias nenv-a="nodenv alias"
alias nenv-dpia="nodenv default-packages install --all"
