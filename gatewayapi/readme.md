sudo helm install eg \
  oci://docker.io/envoyproxy/gateway-helm \
  --version v1.9.1 \
  -n envoy-gateway-system \
  --kubeconfig=/etc/kubernetes/admin.conf \
  --create-namespace

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  wait --timeout=5m \
  -n envoy-gateway-system \
  deployment/envoy-gateway \
  --for=condition=Available

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get pods -n envoy-gateway-system -o wide

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get crd | grep gateway.networking.k8s.io

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  api-resources --api-group=gateway.networking.k8s.io

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f gatewayclass.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get gatewayclass

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  create namespace gateway-system

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f gateway.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get gateway -n gateway-system -o wide

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f main-gateway.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get gateway main-gateway -n gateway-system

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f http-to-https.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get httproute -n gateway-system