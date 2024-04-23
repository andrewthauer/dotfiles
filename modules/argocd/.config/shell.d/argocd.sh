#
# ArgoCD helpers
#

if ! command_exists "argocd"; then
  return 1
fi

argocd-password() {
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
}
