#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with Label-based Delegation -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl apply -f routes/httpbin-httproute.yaml

kubectl apply -f routes/api-example-com-root-httproute-2.yaml



