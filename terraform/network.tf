resource "libvirt_network" "default" {
  name      = var.libvirt_network
  autostart = true

  forward = {
    mode = "open"
  }

  bridge = {
    name  = "virbr0"
    stp   = "on"
    delay = 0
  }

  mac = {
    address = "52:54:00:0d:a5:c6"
  }

  ips = [
    {
      address = "192.168.122.1"
      netmask = "255.255.255.0"

      dhcp = {
        ranges = [
          {
            start = "192.168.122.2"
            end   = "192.168.122.199"
          }
        ]

        hosts = [
          for name, node in var.nodes : {
            name = name
            mac  = node.mac
            ip   = node.ip
          }
        ]
      }
    }
  ]
}