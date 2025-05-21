#!/usr/bin/env bash
set -euo pipefail

# Set base chart directory. By default it will be ../charts
BASE_DIR="${1:-../charts}"

DEV_SECRET="${DEV_SECRET:-DEV_SECRET_1}"
PROD_SECRET="${PROD_SECRET:-PROD_SECRET_1}"


# Check if helm, kubectl and minikube are installed with a loop
for cmd in helm kubectl minikube; do
  command -v "${cmd}" >/dev/null || { echo "${cmd} is required"; exit 1; }
done

set -x

repos=(
  "traefik https://helm.traefik.io/traefik" # traefik
  "jetstack https://charts.jetstack.io" # cert-manager
)

for repo in "${repos[@]}"; do
  name=${repo%% *}
  url=${repo#* }
  helm repo add "$name" "$url" --force-update
done
helm repo update

exit 0


# Install Traefik (auto-create namespace)
helm upgrade traefik traefik/traefik --namespace traefik --create-namespace --values ${BASE_DIR}/traefik/values.yaml \
--wait --timeout 2m --atomic


# Install cert-manager
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace  --set crds.enabled=true \
  --wait --timeout 2m --atomic \
  --set extraArgs="{--enable-certificate-owner-ref}" # Make sure auto created secrets are deleted when the owner is deleted

helm upgrade --install ssl ${BASE_DIR}/ssl --namespace cert-manager --wait --timeout 2m --atomic


helm upgrade --install reflector oci://ghcr.io/emberstack/helm-charts/reflector


# Install website
helm upgrade --install website-dev ${BASE_DIR}/website --namespace dev --create-namespace \
  --values ${BASE_DIR}/website/values-dev.yaml --set secretMessage="${DEV_SECRET}" \
  --wait --timeout 2m --atomic

helm upgrade --install website-prod ${BASE_DIR}/website --namespace prod --create-namespace \
  --values ${BASE_DIR}/website/values-prod.yaml --set secretMessage="${PROD_SECRET}" \
  --wait --timeout 2m --atomic