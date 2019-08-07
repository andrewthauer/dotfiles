#
# Initialize kubernetes module
#

if [[ -x "$(command -v kubectl)" ]]; then
  # load kubectl completions
  if [[ ! -z $ZSH_VERSION ]]; then
    source <(kubectl completion zsh)
  elif [[ ! -z $BASH_VERSION ]]; then
    source <(kubectl completion bash)
  fi

  # load aliases
  source "${DOTFILES_MODULES_DIR}/kubernetes/aliases.sh"
fi
