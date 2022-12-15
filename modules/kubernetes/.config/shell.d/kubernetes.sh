#
# Initialize kubernetes environment
#

if command_exists "helm"; then
  # make helm more xdg compliant
  export HELM_HOME="${XDG_DATA_HOME}/helm"
fi

#
# Kubectl
#
# - https://kubernetes.io/docs/tasks/tools/install-kubectl/
# - https://kubernetes.io/docs/reference/kubectl/cheatsheet

# Setup kubectl for the shell
if command_exists "kubectl"; then
  # make helm more xdg compliant
  export KUBECONFIG="${XDG_CONFIG_HOME}/kube/config"

  _init_kubectl() {
    # load kubectl completions
    if [[ -n $ZSH_VERSION ]]; then
      # shellcheck disable=SC1090
      source <(kubectl completion zsh)
    elif [[ -n $BASH_VERSION ]]; then
      # shellcheck disable=SC1090
      source <(kubectl completion bash)
    fi
    unset -f "$0"
  }

  # initialize kubectl completions (lazy)
  lazyfunc _init_kubectl "kubectl"

# Return if requirements not found
else
  return 1
fi

#
# Aliases
#

alias k='kubectl'
alias kd='kubectl describe'
alias kga='kubectl get deployments,pods,services --all-namespaces'
alias khelp='open https://kubernetes.io/docs/reference/kubectl/cheatsheet'
alias klog='kubectl logs'
