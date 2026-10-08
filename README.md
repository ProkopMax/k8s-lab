# K8s Lab

Local infrastructure lab based on:

- Ubuntu 26.04
- KVM/libvirt
- Terraform
- Ansible
- Kubespray
- Kubernetes
- MetalLB
- Bind9

## Network

Host:
192.168.111.128
Domain:
k8s.lab
Libvirt:
192.168.122.0/24
Gateway:
192.168.122.1

## VMs

| Host | IP | Role |
|---|---|---|
| k8s-cp-01 | 192.168.122.101 | control-plane |
| k8s-worker-01 | 192.168.122.102 | worker |
| k8s-worker-02 | 192.168.122.103 | worker |
| gitlab-01 | 192.168.122.104 | gitLab |

## Kubernetes cluster

| Host | IP | Role |
|---|---|---|
| k8s-cp-01 | 192.168.122.101 | control-plane |
| k8s-worker-01 | 192.168.122.102 | worker |
| k8s-worker-02 | 192.168.122.103 | worker |