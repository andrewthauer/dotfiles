#
# Kubernetes aliases
#
# See - https://kubernetes.io/docs/reference/kubectl/cheatsheet/

alias k="kubectl"

# resources
alias kgpa="kubectl get pods --all-namespaces"
alias kgpau="kgpa -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c"
