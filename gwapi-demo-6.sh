#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with Delegation -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl apply -f routes/httpbin-httproute.yaml

kubectl apply -f routes/api-example-com-root-httproute.yaml



