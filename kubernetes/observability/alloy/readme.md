helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm upgrade --install alloy \
  grafana/alloy \
  --kubeconfig=${HOME}/.kube/config \
  --version 1.13.0 \
  -n observability \
  -f observability/alloy/values.yaml