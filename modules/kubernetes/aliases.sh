#
# Kubernetes aliases
#

# general
alias k="kubectl"
alias kcheat="open https://kubernetes.io/docs/reference/kubectl/cheatsheet"

# viewing resources
alias kgc="kubectl config get-contexts"
alias kpods="kubectl get pods"
alias kpodsa="kubectl get pods --all-namespaces"
alias kpodsi="kpods -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c"
