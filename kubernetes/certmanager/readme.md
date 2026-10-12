sudo helm upgrade --install cert-manager \
  oci://quay.io/jetstack/charts/cert-manager \
  --kubeconfig=/etc/kubernetes/admin.conf \
  --version v1.21.2 \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --set config.gatewayAPI.enabled=true

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get pods -n cert-manager -o wide

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get crd | grep cert-manager.io

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f cert-manager-selfsigned.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get clusterissuer

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f k8s-lab-root-ca.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get certificate -n cert-manager

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f k8s-lab-ca-issuer.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get clusterissuer

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf   get secret k8s-lab-root-ca   -n cert-manager   -o jsonpath='{.data.ca\.crt}' | base64 -d

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get secret k8s-lab-root-ca \
  -n cert-manager \
  -o jsonpath='{.data.ca\.crt}' | base64 -d > /tmp/k8s-lab-root-ca.crt

openssl x509 \
  -in /tmp/k8s-lab-root-ca.crt \
  -noout \
  -subject \
  -issuer \
  -dates

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f k8s-lab-wildcard.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get certificate -n gateway-system

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get secret k8s-lab-tls \
  -n gateway-system \
  -o jsonpath='{.data.tls\.crt}' | base64 -d > /tmp/k8s-lab-tls.crt

openssl x509 \
  -in /tmp/k8s-lab-tls.crt \
  -noout \
  -subject \
  -issuer \
  -dates \
  -ext subjectAltName