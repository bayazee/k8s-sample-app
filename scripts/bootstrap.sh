#!/usr/bin/env bash
set -euo pipefail
set -x

# Set base chart directory. By default it will be ../charts
BASE_DIR="${1:-../charts}"


# Add Helm repos
helm repo add traefik https://helm.traefik.io/traefik --force-update
helm repo update

# Install Traefik (auto-create namespace)
helm upgrade traefik traefik/traefik --namespace traefik --create-namespace --values ${BASE_DIR}/traefik/values.yaml


# Install cert-manager
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace  --set crds.enabled=true \
  --set extraArgs="{--enable-certificate-owner-ref}" # Make sure auto created secrets are deleted when the owner is deleted

helm upgrade --install ssl ${BASE_DIR}/ssl --namespace cert-manager


helm upgrade --install reflector oci://ghcr.io/emberstack/helm-charts/reflector


# Install website
helm upgrade --install website-dev ${BASE_DIR}/website --namespace dev --create-namespace --values ${BASE_DIR}/website/values-dev.yaml --set secretMessage="DEV_SECRET_1"
helm upgrade --install website-prod ${BASE_DIR}/website --namespace prod --create-namespace --values ${BASE_DIR}/website/values-prod.yaml --set secretMessage="PROD_SECRET_1"