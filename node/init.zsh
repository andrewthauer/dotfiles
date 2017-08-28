#
# Node.js environment initialization
#

# NVM support
# Using - https://github.com/lukechilds/zsh-nvm

# Yarn support
if [[ -d "${HOME}/.yarn" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi
