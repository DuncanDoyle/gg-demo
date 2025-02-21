#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with RouteOptions -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl apply -f policies/extauth/oauth-oidc-acf-authconfig.yaml
kubectl apply -f policies/oidc-acf-routeoption.yaml

kubectl apply -f routes/httpbin-example-com-httproute-with-routeoption.yaml



