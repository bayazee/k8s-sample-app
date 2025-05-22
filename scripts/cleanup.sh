#!/usr/bin/env bash
set -euo pipefail

# This script is used to clean up the environment by uninstalling all Helm releases,
# deleting namespaces, CRDs, and the secret-syncer deployment.

# TODO: Imrrove by removing hardcoded values. Fetch installed releases and namespaces from the cluster and helm.

# cleanup.sh [BASE_DIR]
BASE_DIR="${1:-../charts}"

# Ask for confirmation
read -r -p "This will uninstall *ALL* Helm releases, delete namespaces, CRDs, and syncer. Continue? [y/N] " answer
answer=$(printf '%s' "$answer" | tr '[:upper:]' '[:lower:]')
case "${answer}" in 
  y|yes) 
    echo "Proceeding with cleanup…"
    ;;
  *) 
    echo "Aborting."
    exit 1
    ;;
esac

set -x

# Uninstall Helm releases
releases=(
    "prod:website-prod"
    "dev:website-dev"
    "cert-manager:reflector"
    "cert-manager:ssl"
    "cert-manager:cert-manager"
    "traefik:traefik"
)

for release in "${releases[@]}"; do
    IFS=":" read -r namespace name <<< "$release"
    helm uninstall "$name" -n "$namespace" || true
done

# Delete namespaces
kubectl delete namespace prod dev cert-manager traefik || true

# Remove cert-manager CRDs
crds=(
  certificates.cert-manager.io
  issuers.cert-manager.io
  clusterissuers.cert-manager.io
  certificaterequests.cert-manager.io
  orders.acme.cert-manager.io
  challenges.acme.cert-manager.io
)
for crd in "${crds[@]}"; do
  kubectl delete crd "$crd" || true
done

# Tear down the secret-syncer 
kubectl delete deployment secret-syncer -n cert-manager || true
kubectl delete clusterrole secret-syncer || true
kubectl delete clusterrolebinding secret-syncer || true
kubectl delete serviceaccount secret-syncer -n cert-manager || true

echo "Cleanup complete."