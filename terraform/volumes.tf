resource "libvirt_volume" "node_disk" {
  for_each = var.nodes

  name = "${each.key}.qcow2"
  pool = var.libvirt_pool

  capacity      = each.value.disk_gb * 1024 * 1024 * 1024
  capacity_unit = "B"

  target = {
    format = {
      type = "qcow2"
    }
  }

  backing_store = {
    path = var.base_image

    format = {
      type = "qcow2"
    }
  }
}