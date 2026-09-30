helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace observability

helm upgrade --install prometheus prometheus-community/prometheus \
  --kubeconfig=${HOME}/.kube/config \
  -n observability \
  -f observability/prometheus/values.yaml