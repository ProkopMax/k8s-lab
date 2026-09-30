resource "libvirt_domain" "node" {
  for_each = var.nodes

  name = each.key
  type = "kvm"

  memory      = each.value.memory_mb
  memory_unit = "MiB"
  vcpu        = each.value.cpu

  cpu = {
    mode = "host-passthrough"
  }


  running   = true
  autostart = true

  os = {
    type         = "hvm"
    type_arch    = "x86_64"
    type_machine = "q35"
  }

  features = {
    acpi = true
  }

  devices = {
    disks = [
      {
        device = "disk"

        driver = {
          name = "qemu"
          type = "qcow2"
        }

        source = {
          volume = {
            pool   = libvirt_volume.node_disk[each.key].pool
            volume = libvirt_volume.node_disk[each.key].name
          }
        }

        target = {
          dev = "vda"
          bus = "virtio"
        }
      },

      {
        device   = "cdrom"
        readonly = true

        source = {
          volume = {
            pool   = libvirt_volume.cloudinit[each.key].pool
            volume = libvirt_volume.cloudinit[each.key].name
          }
        }

        target = {
          dev = "sda"
          bus = "sata"
        }
      }
    ]

    interfaces = [
      {
        type = "network"

        mac = {
          address = each.value.mac
        }

        source = {
          network = {
            network = var.libvirt_network
          }
        }

        model = {
          type = "virtio"
        }

      }
    ]
  }
}