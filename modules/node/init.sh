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

#
# Yarn support
#

if [[ -d "${HOME}/.yarn" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi

#
# Aliases & helpers
#

# Skip if node is not installed
if ! [[ -x "$(command -v node)" ]]; then
  return
fi

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"
