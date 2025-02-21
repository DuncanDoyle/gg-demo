#!/bin/sh

#----------------------------------------- HTTPBin API Product -----------------------------------------

kubectl create namespace tracks --dry-run=client -o yaml | kubectl apply -f -

printf "\nLabel tracks namespace ...\n"
kubectl label namespaces tracks --overwrite shared-gateway-access="true"

kubectl apply -f policies/extauth/oauth-oidc-atv-authconfig.yaml
kubectl apply -f policies/oidc-atv-routeoption.yaml

printf "\nDeploy Tracks service ...\n"
kubectl apply -f apis/tracks/tracks-api-1.0.yaml
printf "\nDeploy the Tracks HTTPRoute (delegatee) and the HTTP APIProduct ...\n"
kubectl apply -f apiproduct/tracks/tracks-httproute.yaml
kubectl apply -f apiproduct/tracks/tracks-apiproduct-httproute.yaml
kubectl apply -f apiproduct/tracks/tracks-v2-apiproduct-httproute.yaml
kubectl apply -f apiproduct/tracks/tracks-apiproduct.yaml
kubectl apply -f referencegrant/tracks-ns/portal-tracks-apiproduct-reference-grant.yaml

