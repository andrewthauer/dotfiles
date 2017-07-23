#
# Node.js helpers & aliases
#

# NVM support
# Using - https://github.com/lukechilds/zsh-nvm

# Yarn support
if [[ -d "${HOME}/.yarn" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi

# aliases
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"
