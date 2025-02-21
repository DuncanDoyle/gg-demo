#!/bin/sh

#----------------------------------------- HTTPBin Route -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl apply -f routes/httpbin-example-com-httproute.yaml