vm_user     = "tech"
vm_password = "tech"

nodes = {
  k8s-cp-01 = {
    ip        = "192.168.122.101"
    mac       = "52:54:00:aa:bb:01"
    role      = "control-plane"
    cpu       = 2
    memory_mb = 4096
    disk_gb   = 40
  }

  k8s-worker-01 = {
    ip        = "192.168.122.102"
    mac       = "52:54:00:aa:bb:02"
    role      = "worker"
    cpu       = 4
    memory_mb = 8192
    disk_gb   = 40
  }

  k8s-worker-02 = {
    ip        = "192.168.122.103"
    mac       = "52:54:00:aa:bb:03"
    role      = "worker"
    cpu       = 4
    memory_mb = 8192
    disk_gb   = 40
  }

  gitlab-01 = {
    ip        = "192.168.122.104"
    mac       = "52:54:00:aa:bb:04"
    role      = "gitlab"
    cpu       = 2
    memory_mb = 6144
    disk_gb   = 40
  }
}
