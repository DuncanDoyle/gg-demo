#!/bin/sh

#----------------------------------------- HTTPBin Route -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl apply -f referencegrant/httpbin-ns/api-example-com-httpbin-reference-grant-service.yaml