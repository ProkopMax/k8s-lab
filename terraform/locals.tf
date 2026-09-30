locals {
  control_plane_nodes = {
    for name, node in var.nodes :
    name => node
    if node.role == "control-plane"
  }

  worker_nodes = {
    for name, node in var.nodes :
    name => node
    if node.role == "worker"
  }
}