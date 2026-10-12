sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f https://raw.githubusercontent.com/metallb/metallb/v0.16.1/config/manifests/metallb-native.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f ipaddresspool.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  -n metallb-system get ipaddresspool,l2advertisement
