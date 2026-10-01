helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm upgrade --install tempo grafana/tempo \
  --kubeconfig=${HOME}/.kube/config \
  --namespace observability \
  --create-namespace \
  -f observability/tempo/values.yaml