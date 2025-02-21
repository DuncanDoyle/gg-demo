#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with Delegation -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl apply -f apiproduct/httpbin/httpbin-apiproduct-httproute.yaml

kubectl apply -f routes/httpbin-example-com-root-httproute.yaml



