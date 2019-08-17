#
# Initialize kubernetes module
#

_init_kubectl() {
  # load kubectl completions
  if [[ -n $ZSH_VERSION ]]; then
    source <(kubectl completion zsh)
  elif [[ -n $BASH_VERSION ]]; then
    source <(kubectl completion bash)
  fi

  unset -f "$0"
}

if command_exists "kubectl"; then
  # initialize kubectl completions (lazy)
  kubectl() { unset -f "$0"; _init_kubectl; $0 "$@"; }

  # load aliases
  source "${DOTFILES_MODULES_DIR}/kubernetes/aliases.sh"
fi
