#
# Initialize kubectl environment
#
# - https://kubernetes.io/docs/tasks/tools/install-kubectl/
#

if ! command_exists "kubectl"; then
  return
fi

_init_kubectl() {
  # load kubectl completions
  if [ -n $ZSH_VERSION ]; then
    source <(kubectl completion zsh)
  elif [ -n $BASH_VERSION ]; then
    source <(kubectl completion bash)
  fi
  unset -f $0
}

# initialize kubectl completions (lazy)
kubectl() { unset -f "$0"; _init_kubectl; $0 "$@"; }
