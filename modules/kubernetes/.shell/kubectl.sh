#
# Initialize kubectl environment
#
# - https://kubernetes.io/docs/tasks/tools/install-kubectl/
# - https://kubernetes.io/docs/reference/kubectl/cheatsheet
#

if ! command_exists "kubectl"; then
  return 1
fi

_init_kubectl() {
  # load kubectl completions
  if [[ -n $ZSH_VERSION ]]; then
    source <(kubectl completion zsh)
  elif [[ -n $BASH_VERSION ]]; then
    source <(kubectl completion bash)
  fi
  unset -f $0
}

# initialize kubectl completions (lazy)
lazyfunc _init_kubectl "kubectl"

#
# Aliases
#

# general
alias k="kubectl"
alias kcheat="open https://kubernetes.io/docs/reference/kubectl/cheatsheet"

# config & contexts
alias kgc="kubectl config get-contexts"

# describe
alias kdesc="kubectl describe"
alias kdescp="kubectl describe pods"

# resources
alias kpods="kubectl get pods"
alias kpodsa="kubectl get pods --all-namespaces"
alias kpodsi="kpods -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c"

# logs
alias klog="kubectl logs"
