#!/bin/sh

#----------------------------------------- HTTPBin API Product -----------------------------------------

printf "\nDeploy HTTPBin APISchemaDiscovery ...\n"
kubectl apply -f apis/httpbin/httpbin-apischemadiscovery.yaml

kubectl apply -f referencegrant/httpbin-ns/portal-httpbin-apiproduct-reference-grant.yaml

