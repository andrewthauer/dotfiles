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

# Return if requirements not found
else
  return 1
fi

#
# Aliases
#

# kubectl
alias k='kubectl'
alias kd='kubectl describe -'
alias kga='kubectl get all -A'
alias kgy='kubectl get -o yaml'
alias khelp='open https://kubernetes.io/docs/reference/kubectl/cheatsheet'
alias klog='kubectl logs'
alias krestart='kubectl rollout restart'
alias krestartd='kubectl rollout restart deployment'
alias kexec='kubectl exec --stdin --tty'

# minikube
alias mk="minikube"
alias mkk="minikube kubectl --"
