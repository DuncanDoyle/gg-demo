#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with Label-based Delegation -----------------------------------------

kubectl apply -f routes/httpbin-httproute.yaml

kubectl apply -f routes/api-example-com-root-httproute-2.yaml

################################################################################################## 
# Demo: Show the status of HTTPRoute to show that the route has been correctly deployed.
#
# $ kubectl -n default get httproute api-example-com -o yaml
#
# Demo: Show that we can access the HTTPBin service.
#
# $ curl -v http://api.example.com/httpbin/get
##################################################################################################

