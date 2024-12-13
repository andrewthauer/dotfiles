# Cheatsheet

## ArgoCD

```sh
# Get the initial password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## AWS

```sh
# who am i
aws sts get-caller-identity
```
