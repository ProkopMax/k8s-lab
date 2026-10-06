resource "libvirt_cloudinit_disk" "node" {
  for_each = var.nodes

  name = "${each.key}-cloudinit.iso"

  user_data = templatefile(
    "${path.module}/templates/user-data.yaml.tftpl",
    {
      hostname = each.key
      username = var.vm_user
      password = var.vm_password
    }
  )

  meta_data = <<-EOF
    instance-id: ${each.key}
    local-hostname: ${each.key}
  EOF

  network_config = templatefile(
    "${path.module}/templates/network-config.yaml.tftpl",
    {
      ip  = each.value.ip
      mac = each.value.mac
    }
  )
}

resource "libvirt_volume" "cloudinit" {
  for_each = var.nodes

  name = "${each.key}-cloudinit.iso"
  pool = var.libvirt_pool

  create = {
    content = {
      url = libvirt_cloudinit_disk.node[each.key].path
    }
  }
}