#!/bin/sh

#----------------------------------------- HTTPBin Route -----------------------------------------

# Deploy httproute
kubectl apply -f routes/api-example-com-httproute.yaml

################################################################################################## 
# Demo: Show that the httproute has not been accepted by the listener because the namespace does not have the proper label.
#
# $ kubectl -n default get httproute api-example-com -o yaml
##################################################################################################