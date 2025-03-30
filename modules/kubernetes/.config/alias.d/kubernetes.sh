# general
alias k="kubectl"
alias khelp="open https://kubernetes.io/docs/reference/kubectl/cheatsheet"

# describe
alias kd="kubectl describe"

# get
alias kg="kubectl get"
alias kga="kubectl get all -A"
alias kgy="kubectl get -o yaml"

# get additional
alias kgconf="kubectl get configmap"
alias kgsec="kubectl get secret"

# logs
alias klog="kubectl logs"

# pods
alias k-pod-names='kubectl get pods --no-headers -o custom-columns=":metadata.name"'

# debugging
alias keit="kubectl exec -it"
alias ketty="kubectl exec --stdin --tty"
