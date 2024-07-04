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
# kubectl apply -f referencegrant/api-example-com-httpbin-reference-grant-service.yaml

printf "\nDeploy HTTPBin APISchemaDiscovery ...\n"
kubectl apply -f apis/httpbin/httpbin-apischemadiscovery.yaml

printf "\nDeploy the HTTPBin HTTPRoute (delegatee) and the HTTP APIProduct ...\n"
kubectl apply -f apiproduct/httpbin/httpbin-apiproduct-httproute.yaml
kubectl apply -f apiproduct/httpbin/httpbin-apiproduct.yaml
kubectl apply -f referencegrant/httpbin-ns/portal-httpbin-apiproduct-reference-grant.yaml


#----------------------------------------- ExtAuth -----------------------------------------

kubectl apply -f policies/opa/oauth-scope-apiproduct-opa-cm.yaml
kubectl apply -f policies/extauth/oauth-oidc-atv-authconfig.yaml

#----------------------------------------- Tracks API Product -----------------------------------------

kubectl create namespace tracks --dry-run=client -o yaml | kubectl apply -f -

printf "\nLabel tracks namespace ...\n"
kubectl label namespaces tracks --overwrite shared-gateway-access="true"

kubectl apply -f policies/oidc-atv-routeoption.yaml

printf "\nDeploy Tracks service ...\n"
kubectl apply -f apis/tracks/tracks-api-1.0.yaml
printf "\nDeploy the Tracks HTTPRoute (delegatee) and the HTTP APIProduct ...\n"
kubectl apply -f apiproduct/tracks/tracks-httproute.yaml
kubectl apply -f apiproduct/tracks/tracks-apiproduct-httproute.yaml
kubectl apply -f apiproduct/tracks/tracks-apiproduct.yaml
kubectl apply -f referencegrant/tracks-ns/portal-tracks-apiproduct-reference-grant.yaml


#----------------------------------------- api.example.com route -----------------------------------------

# Label the default namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel default namespace ...\n"
kubectl label namespaces default --overwrite shared-gateway-access="true"

printf "\nDeploy the HTTPRoute ...\n"
kubectl apply -f routes/api-example-com-root-httproute.yaml

#----------------------------------------- Portal -----------------------------------------

kubectl apply -f referencegrant/gloo-system-ns/httproute-portal-reference-grant.yaml
kubectl apply -f referencegrant/gloo-system-ns/portal-reference-grant.yaml

kubectl apply -f portal/portal.yaml
kubectl apply -f portal/portal-frontend.yaml

# kubectl apply -f policies/portal-cors-route-option.yaml
kubectl apply -f policies/portal-route-option.yaml

kubectl apply -f routes/portal-server-httproute.yaml

popd

