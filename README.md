# Spotifyd on the Raspberry Pi

The repository contains a Docker image that runs [spotifyd](https://github.com/Spotifyd/spotifyd) for use with a Raspberry Pi.

## K3s
If the Raspberry Pi is part of a K3s cluster, the manifest in `k3s` can applied to deploy the container with all the required environment variables and volume mounts.

However, to ensure the pod is deployed to the correct node in the cluster, a label and a taint should be added first. Assuming the node is called `rpi-x`, run:
```shell
kubectl label node rpi-x device=hifi
kubectl taint nodes rpi-x device=hifi:NoSchedule
kubectl apply -f k3s/spotifyd.yaml
```

