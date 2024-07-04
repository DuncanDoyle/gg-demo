# Gloo Gateway 1.17 - Kubernetes Gateway API

## Installation

Install Gloo Gateway:
```
cd install
./install-gloo-gateway-with-helm.sh
```

> [!NOTE]
> The Gloo Gateway version that will be installed is set in a variable at the top of the `install/install-gloo-edge-enterprise-with-helm.sh` installation script.

Verify that the `GatewayClass` has been created:

```
kubectl get gatewayclasses
```

Inspect the `GatewayClass` like so:

```
kubectl get gatewayclass gloo-gateway -o yaml
```


## Setup the environment

Run the `install/setup.sh` script to setup the environment:

- Deploy the Gateway

```
./setup.sh
```

Check that the Gateway has been created:

```
kubectl -n ingress-gw get gateway
```

Inspect the `Gateway` like so:

```
kubectl -n ingress-gw get gateway gw -o yaml
```

Validate that the proxy has been deployed:

```
kubectl -n ingress-gw get deploy
```

Inspect the full set of resources (service, deploy, etc.) inthe `ingress-gw` namespace:

```
kubectl -n ingress-gw get all
```

Port forward to the Admin API:

```
kubectl port-forward -n ingress-gw deploy/gloo-proxy-gw 19000:19000
```

Note that we don't have any dynamic listeners yet:

```
open http://localhost:19000/listeners?format=text
```

List the Proxy CRs using the CLI:

```
glooctl get proxies
```

Output the yaml for the generated Proxy CR:

```
glooctl get proxy ingress-gw-gw -oyaml
```

Port-forward the Control-Plane "Admin" API:

```
kubectl port-forward -n gloo-system deployment/gloo 10010:10010
```

Inspect the xDS Snapshots that the Control Plane is serving:

```
open http://localhost:10010/xds
```


## Deploy the HTTPBin service

Deploy the HTTPBin service:

```
kubectl create ns httpbin
kubectl apply -f apis/httpbin.yaml
```

## Routing

Deploy the `ReferenceGrant` to allow the `HTTPRoute` to route to  our httpbin `Service`:

```
kubectl apply -f routs/api-example-com-httpbin-reference-grant.yaml
```

Set the label on the `default` namespace in which we will be deploying our `HTTPRoute`. This is needed because we've configured a label selector on our `Gateway` to filter from which namespaces routes will be accepted:

```
kubectl label namespaces default --overwrite shared-gateway-access="true"
```

Finally, we can deploy our `HTTPRoute`:

```
kubectl apply -f api-example-com-route.yaml
```

And we can test our httpbin service:

```
curl -v http://api.example.com/httpbin/get
```

When we now look at the Envoy config, we can see that we now fo have dynamic listeners:

```
open http://localhost:19000/listeners?format=text
```

**TODO** THIS DOESN'T SEEM TO WORK IN BETA2!!!! I don't see any listeners here.

## RouteOption ExtensionRef

### Adding Response Headers

Deploy a `RouteOption` CR which will add a header to the response:

```
kubectl apply -f policies/route-option.yaml
```

Next, apply the update `HTTPRoute` CR, which adds a match for `http://api.example.com/httpbin2`. When that route is targeted, the header `gg-demo-header` will be set on the response.

```
kubectl apply -f routes/api-example-com-httproute-with-routeoption.yaml
```

Now call the new route and observe the response headers:

```
curl -v http://api.example.com/httpbin2/get
```

### ExtAuth

Deplof the `AuthConfig` CR:

```
kubectl apply -f policies/extauth/auth-config.yaml
```

Apply the `RouteOption` CR that uses the authconfig we deployed earlier:

```
kubectl apply -f policies/route-option-ac.yaml
```

Observe the ExtAuth server logs and check that the `AuthConfig` has been applied:
```
kubectl -n gloo-system logs -f extauth-{pod-id}
```

Assert the Proxy CR has the policy defined:
```
glooctl get proxy ingress-gw-gw -oyaml
```

Next, try to call the `httpbin2` service, and observe that the request is now being denied with a 401:
```
curl -v http://api.example.com/httpbin2/get
```

Create the `BASIC_AUTH_HEADER` environment variable and send that as a basic-auth header on the HTTP request:

```
BASIC_AUTH_HEADER=$(echo -n "user:password" | base64)
curl -v -H "Authorization: basic $BASIC_AUTH_HEADER" http://api.example.com/httpbin2/get 
```

### RateLimit

Apply the `RouteOption` CR that contains the rate-limit configuration:

```
kubectl apply -f policies/route-option-rl.yaml
```

In the Helm values file, we've configured the RateLimiter to 3 requests per minute. Try to access the `httpbin2` service a couple of times in a row, and notice that at some point, the Gloo Gateway RateLimited will return `429 - Too many requests` HTTP errors:

```
curl -v http://api.example.com/httpbin2/get
```

## VirtualHostOption TargetRef

Apply the `VirtualHostOption` CR that targets our GW:

```
kubectl apply -f policies/virtual-host-option.yaml
```



# Portal

## APISchemaDiscovery

```
kubectl apply -f portal/example-service-apischemadiscovery.yaml
```

# Federation

Run the `install/federated-cluster-registration.sh` script to register the cluster with Gloo Federation and enable access via the Gloo Fed UI:

```
./federated-cluster-registration.sh
```
