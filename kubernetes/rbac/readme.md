sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  create clusterrolebinding oidc-k8s-admins \
  --clusterrole=cluster-admin \
  --group='oidc:k8s-admins'

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get clusterrolebinding oidc-k8s-admins -o yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  auth can-i list nodes \
  --as=oidc:maxim \
  --as-group=oidc:k8s-admins
