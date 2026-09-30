resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = templatefile(
    "${path.module}/templates/inventory.ini.tftpl",
    {
      nodes    = var.nodes
      username = var.vm_user
    }
  )

  depends_on = [
    libvirt_domain.node
  ]
}

resource "local_file" "kubespray_inventory" {
  filename = "${path.module}/../kubespray-2.32/inventory/k8s-lab/inventory.ini"

  content = templatefile(
    "${path.module}/templates/kubespray-inventory.ini.tftpl",
    {
      nodes               = var.nodes
      control_plane_nodes = local.control_plane_nodes
      worker_nodes        = local.worker_nodes
      username            = var.vm_user
    }
  )

  depends_on = [
    libvirt_domain.node
  ]
}