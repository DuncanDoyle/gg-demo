#!/bin/sh

#----------------------------------------- Upstream & VirtualService -----------------------------------------

printf "\nDeploy Upstream ...\n"
kubectl apply -f upstreams/httpbin-upstream.yaml

printf "\nDeploy VirtualService ...\n"
kubectl apply -f virtualservices/api-example-com-vs.yaml

################################################################################################## 
# Demo: Show the status of Upstream and VirtualService.
#
# $ kubectl -n gloo-system get upstream httpbin-httpbin-8000 -o yaml
# $ kubectl -n gloo-system get virtualservice api-example-com -o yaml
#
# Demo: Show that we can access the HTTPBin service.
#
# $ curl -v http://api.example.com/httpbin/get
#
# Demo: Show the httpbin service in a browser
#
# $ open http://api.example.com/httpbin/
##################################################################################################