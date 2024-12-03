#
# Initialize kubernetes environment
#

#
# Environment
#

# make helm more xdg compliant
export KUBECONFIG="${XDG_CONFIG_HOME}/kube/config"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"
export KREW_ROOT="${XDG_CONFIG_HOME}/krew"

# allow krew plugins
append_path "${KREW_ROOT}/bin"

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

# gets all resouce kinds
k-get-kinds() {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "$i"
  done
}
