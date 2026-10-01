kubectl -n observability run netshoot \
  --kubeconfig=${HOME}/.kube/config \
  --image=nicolaka/netshoot:latest \
  --restart=Never \
  --command -- sleep 86400