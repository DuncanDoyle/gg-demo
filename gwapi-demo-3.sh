#!/bin/sh

#----------------------------------------- HTTPBin Route -----------------------------------------

# Label the default namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel default namespace ...\n"
kubectl label namespaces default --overwrite shared-gateway-access="true"

################################################################################################## 
# Demo: Show that there is a referencegrant missing to give the httproute access to the httpbin service.
#
# $ kubectl -n default get httproute api-example-com -o yaml
##################################################################################################