kubectl apply -f observability/external-node-exporter/endpoints.yaml --kubeconfig=${HOME}/.kube/config
kubectl apply -f observability/external-node-exporter/service.yaml --kubeconfig=${HOME}/.kube/config
kubectl apply -f observability/external-node-exporter/servicemonitor.yaml --kubeconfig=${HOME}/.kube/config