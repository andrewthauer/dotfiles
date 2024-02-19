#
# Initialize kubernetes environment
#

#
# Kubectl
#
# - https://kubernetes.io/docs/tasks/tools/install-kubectl/
# - https://kubernetes.io/docs/reference/kubectl/cheatsheet

# general
alias k='kubectl'
alias khelp='open https://kubernetes.io/docs/reference/kubectl/cheatsheet'

# describe
alias kd='kubectl describe'

# get
alias kg='kubectl get'
alias kga='kubectl get all -A' # list all namespaces
alias kgy='kubectl get -o yaml'

# get additional
alias kgconf='kubectl get configmap'
alias kgsec='kubectl get secret'

# logs
alias klog='kubectl logs'

# pods
alias k-pod-names='kubectl get pods --no-headers -o custom-columns=":metadata.name"'

# debugging
alias keit='kubectl exec -it'
alias ketty='kubectl exec --stdin --tty'

# set context
ktx() {
  local context="$1"
  local namespace="$2"

  if [ -n "$namespace" ]; then
    kubectl config use-context "$context" --namespace="$namespace"
  elif [ -n "$context" ]; then
    kubectl config use-context "$context"
  else
    echo "Usage: $0 [context] [namespace]"
    echo
    kubectl config get-contexts
  fi
}

# gets all resouce kinds
k-get-kinds() {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "$i"
  done
}
