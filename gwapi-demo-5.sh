#!/bin/sh

#----------------------------------------- HTTPBin HttpRoute with RouteOptions -----------------------------------------

kubectl apply -f policies/extauth/oauth-oidc-acf-authconfig.yaml
kubectl apply -f policies/oidc-acf-routeoption.yaml

kubectl apply -f routes/api-example-com-httproute-with-routeoption.yaml

################################################################################################## 
#
# Demo: Show that the HTTPBin service is now protected with OAuth/OIDC AuthorizationCodeFlow.
#
# $ open http://api.example.com/httpbin/
#
# Demo: Login with Keycloak
# username: user1@example.com
# password: password
#
# Demo: Access the logout URL and show that we get redirected to Google
#
# http://api.example.com/logout
#
##################################################################################################