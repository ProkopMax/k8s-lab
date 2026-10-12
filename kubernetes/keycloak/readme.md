sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  create namespace keycloak

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -k 'github.com/keycloak/keycloak-k8s-resources/kubernetes?ref=26.7.4'

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get pods -n keycloak

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  -n keycloak create secret generic keycloak-db \
  --from-literal=username=keycloak \
  --from-literal=password='keycloak'

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  exec -it -n database postgres-0 -- \
  psql -U postgres -d postgres

CREATE USER keycloak WITH PASSWORD 'keycloak';
CREATE DATABASE keycloak OWNER keycloak;

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  exec -n database postgres-0 -- \
  psql -U keycloak -d keycloak \
  -c "SELECT current_database(), current_user, version();"

jdbc:postgresql://postgres.database.svc.cluster.local:5432/keycloak

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f keycloak.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get keycloak -n keycloak

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf   get pods -n keycloak

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get keycloak keycloak -n keycloak \
  -o go-template='{{range .status.conditions}}TYPE={{.type}} STATUS={{.status}} MESSAGE={{.message}}{{"\n"}}{{end}}'

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f gateway-route.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get httproute -n keycloak

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  describe httproute keycloak -n keycloak


sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get secret keycloak-initial-admin \
  -n keycloak \
  -o jsonpath='{.data.username}' | base64 -d

echo

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get secret keycloak-initial-admin \
  -n keycloak \
  -o jsonpath='{.data.password}' | base64 -d

echo

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  get secret keycloak-initial-admin \
  -n keycloak \
  -o jsonpath='{.data.password}' | base64 -d

echo