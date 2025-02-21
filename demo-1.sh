#!/bin/sh

#----------------------------------------- HTTPBin API Product -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl create namespace httpbin --dry-run=client -o yaml | kubectl apply -f -

# # Label the httpbin namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel httpbin namespace ...\n"
kubectl label namespaces httpbin --overwrite shared-gateway-access="true"

printf "\nDeploy HTTPBin service ...\n"
kubectl apply -f apis/httpbin/httpbin.yaml

