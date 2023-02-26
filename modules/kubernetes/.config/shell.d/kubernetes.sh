#
# Initialize kubernetes environment
#

#
# helm
#

if command_exists "helm"; then
  # make helm more xdg compliant
  export HELM_HOME="${XDG_DATA_HOME}/helm"
fi

#
# minikube
#

if command_exists "minikube"; then
  # make minikube more xdg compliant
  export MINIKUBE_HOME="${XDG_CONFIG_HOME}/minikube"

  # aliases
  alias mk="minikube"
  alias mkk="minikube kubectl --"
  alias minikube-inject-env='eval "$(minikube docker-env)"'
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
  export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"

# Return if requirements not found
else
  return 1
fi

#
# kubectl
#

# general
alias k='kubectl'
alias khelp='open https://kubernetes.io/docs/reference/kubectl/cheatsheet'

# describe
alias kd='kubectl describe'

# get
alias kg='kubectl get'
alias kga='kubectl get all -A'  # list all namespaces
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

# set default namespace
k-set-ns() {
  kubectl config set-context --current --namespace="$1"
}

# gets all resouce kinds
k-get-kinds() {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "$i"
  done
}

# get all resources in a namespace
k-get-all() {
  local ns="$1"

  for i in $(k-get-kinds); do
    data=$(kubectl -n "${ns}" get --ignore-not-found "${i}")
    if [ -n "$data" ]; then
      echo "--- resource: $i ---"
      echo "$data"
      echo ""
    fi
  done
}
