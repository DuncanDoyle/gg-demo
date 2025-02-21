#!/bin/sh

pushd ..

#----------------------------------------- HTTPBin API Product -----------------------------------------

# Create httpbin namespace if it does not exist yet
kubectl create namespace httpbin --dry-run=client -o yaml | kubectl apply -f -

# # Label the httpbin namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel httpbin namespace ...\n"
kubectl label namespaces httpbin --overwrite shared-gateway-access="true"

printf "\nDeploy HTTPBin service ...\n"
kubectl apply -f apis/httpbin/httpbin.yaml

# printf "\nDeploy the ReferenceGrant. This is needed for cross-namespace routing ...\n"
kubectl apply -f referencegrants/api-example-com-httpbin-reference-grant-service.yaml

#----------------------------------------- ExtAuth -----------------------------------------

kubectl apply -f policies/extauth/oauth-oidc-acf-authconfig.yaml
kubectl apply -f policies/oidc-acf-routeoption.yaml

#----------------------------------------- api.example.com route -----------------------------------------

# Label the default namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel default namespace ...\n"
kubectl label namespaces default --overwrite shared-gateway-access="true"

printf "\nDeploy the HTTPRoute ...\n"
kubectl apply -f routes/api-example-com-httproute-with-routeoption.yaml

popd

