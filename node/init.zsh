#
# Node.js environment initialization
#

#
# NVM support
# - https://github.com/lukechilds/zsh-nvm
#

if [[ -d "${HOME}/.nvm" ]]; then
  export NVM_AUTO_USE=true

  # Enable lazy loading (when NOT inside vscode
  if [ -z "$VSCODE_PID" ]; then
    export NVM_LAZY_LOAD=true
  fi
fi

#
# Yarn support
#

if [[ -d "${HOME}/.yarn" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi
