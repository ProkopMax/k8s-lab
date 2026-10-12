sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  create namespace database

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  create secret generic postgres-admin \
  -n database \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=POSTGRES_PASSWORD='postgres'

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f service.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f headless-service.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  apply -f statefulset.yaml

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf   get sts,pods,pvc,svc -n database -o wide

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf \
  exec -it -n database postgres-0 -- \
  psql -U postgres -d postgres