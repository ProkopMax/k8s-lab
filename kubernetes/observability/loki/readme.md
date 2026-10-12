helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm upgrade --install loki \
  grafana/loki \
  --kubeconfig=${HOME}/.kube/config \
  --version 7.3.0 \
  -n observability \
  -f observability/loki/values.yaml