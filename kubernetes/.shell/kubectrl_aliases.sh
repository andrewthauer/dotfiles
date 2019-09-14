#
# kubectl aliases
#
# - https://kubernetes.io/docs/reference/kubectl/cheatsheet
#

if ! command_exists "kubectl"; then
  return
fi
# general
alias k="kubectl"
alias kcheat="open https://kubernetes.io/docs/reference/kubectl/cheatsheet"

# config & contexts
alias kgc="kubectl config get-contexts"

# resources
alias kpods="kubectl get pods"
alias kpodsa="kubectl get pods --all-namespaces"
alias kpodsi="kpods -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c"

# logs
alias klog="kubectl logs"
