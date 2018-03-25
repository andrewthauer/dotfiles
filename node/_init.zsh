#
# Node.js environment initialization
#

# nvm support (https://github.com/creationix/nvm)
if [[ -d "${HOME}/.nvm" ]]; then
  # Initialize nvm if not already done
  if ! [ -x "$(command -v nvm)" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  fi

  #
  # zsh-nvm plugin (https://github.com/lukechilds/zsh-nvm)
  #

  # Automatically use .nvmrc
  export NVM_AUTO_USE=true

  # Enable lazy loading (when NOT inside vscode)
  if [ -z "$VSCODE_PID" ]; then
    export NVM_LAZY_LOAD=true
  fi
fi

# Yarn support
if [[ -d "${HOME}/.yarn" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi
