#!/bin/sh

#----------------------------------------- Portal -----------------------------------------

kubectl apply -f referencegrant/gloo-system-ns/httproute-portal-reference-grant.yaml
kubectl apply -f referencegrant/gloo-system-ns/portal-reference-grant.yaml

kubectl apply -f portal/portal.yaml
kubectl apply -f portal/portal-frontend.yaml

kubectl apply -f policies/portal-route-option.yaml

kubectl apply -f routes/portal-server-httproute.yaml
