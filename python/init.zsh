#
# Python initialization
#

# pyenv support (https://github.com/pyenv/pyenv)
if [[ -d "${HOME}/.pyenv" ]]; then
  # Add pyenv to the path
  if (( ! $+commands[pyenv] )); then
    export PATH="${HOME}/.pyenv/bin:${PATH}"
  fi

  # Initialize pyenv (prepends ~/.pyenv/shims" to $PATH)
  eval "$(pyenv init -)"
fi

# Source module files
source "${0:h}/aliases.zsh"
