helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace observability --kubeconfig=${HOME}/.kube/config

helm upgrade --install kube-prometheus-stack \
  prometheus-community/kube-prometheus-stack \
  --kubeconfig=${HOME}/.kube/config \
  -n observability \
  -f observability/prometheus/values.yaml