#!/bin/sh

#----------------------------------------- HTTPBin Route -----------------------------------------

# Label the default namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel default namespace ...\n"
kubectl label namespaces default --overwrite shared-gateway-access="true"