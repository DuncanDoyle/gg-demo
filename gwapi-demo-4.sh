#!/bin/sh

#----------------------------------------- HTTPBin Route -----------------------------------------

kubectl apply -f referencegrants/httpbin-ns/httproute-default-service-rg.yaml

################################################################################################## 
# Demo: Show the status of HTTPRoute to show that the route has been correctly deployed.
#
# $ kubectl -n default get httproute api-example-com -o yaml
#
# Demo: Show that we can access the HTTPBin service.
#
# $ curl -v http://api.example.com/httpbin/get
#
# Demo: Show the httpbin service in a browser
#
# $ open http://api.example.com/httpbin/
##################################################################################################
