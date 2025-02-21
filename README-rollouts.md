```
kubectl argo rolloust list rollouts -A
```

```
kubectl argo rollouts -n httpbin get rollout httpbin
```

```
kubectl argo rollouts dashboard
```

```
kubectl -n httpbin get svc httpbin -o yaml
```
Note the selector field:
```
selector:
    app: httpbin
    rollouts-pod-template-hash: 7d9f4c9cfc
```
Which is used to point to the `ReplicaSet`  that manages the stable pods.

```
kubectl -n httpbin get replicaset httpbin-{id} -o yaml
```


We can trigger a rollout by updating the image of the httpbin container:

```
kubectl argo rollouts -n httpbin set image httpbin httpbin=docker.io/mccutchen/go-httpbin:v2.7.0
```

Check the rollout

```
kubectl argo rollouts -n httpbin get rollout httpbin
```

Go to the next step of the rollout by running this command:

```
kubectl argo rollouts -n httpbin promote httpbin
```