sudo helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
sudo helm repo update

sudo helm search repo csi-driver-nfs

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf create namespace nfs-provisioner

sudo helm install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
  --namespace nfs-provisioner \
  --kubeconfig=/etc/kubernetes/admin.conf

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf get pods -n nfs-provisioner

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f storageclass-nfs.yaml