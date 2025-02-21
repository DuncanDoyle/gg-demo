#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with Label-based Delegation -----------------------------------------

# Reference Grant to allow access to the TLS Cert secret.
kubectl apply -f referencegrants/gloo-system-ns/gw-ingress-gw-secret-reference-grant.yaml

# Create httpbin namespace if it does not exist yet
kubectl apply -f routes/api-example-com-https-route.yaml


################################################################################################## 
# Demo: Show the status of HTTPRoute to show that the route has been correctly deployed.
#
# $ kubectl -n default get httproute api-example-com -o yaml
#
# Demo: Show that we can access the HTTPBin service.
#
# $ curl -vk https://api.example.com/httpbin/get
##################################################################################################