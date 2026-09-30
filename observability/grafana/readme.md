kubectl apply --kubeconfig=${HOME}/.kube/config \
  -n observability \
   -f observability/grafana/gateway-route.yaml 