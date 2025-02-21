#!/bin/sh

helm upgrade --install argo-rollouts argo-rollouts \
  --repo https://argoproj.github.io/argo-helm \
  --version 2.35.3 \
  --namespace argo-rollouts \
  --create-namespace \
  --wait \
  -f argo-rollouts-helm-values.yaml