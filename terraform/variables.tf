variable "libvirt_uri" {
  description = "Libvirt connection URI"
  type        = string
  default     = "qemu:///system"
}

variable "libvirt_network" {
  description = "Libvirt network name"
  type        = string
  default     = "default"
}

variable "libvirt_pool" {
  description = "Libvirt storage pool"
  type        = string
  default     = "k8s-lab"
}

variable "volume_format" {
  description = "Format is required"
  type        = string
  default     = "qcow2"
}

variable "base_image" {
  description = "Ubuntu cloud image"
  type        = string
  default     = "/var/lib/libvirt/images/k8s-lab/ubuntu-26.04-server-cloudimg-amd64.img"
}

variable "nodes" {
  description = "Kubernetes nodes"

  type = map(object({
    ip        = string
    mac       = string
    role      = string
    cpu       = number
    memory_mb = number
    disk_gb   = number
  }))
}

variable "vm_user" {
  description = "Default VM user"
  type        = string
  default     = "tech"
}

variable "vm_password" {
  description = "Password for VM user"
  type        = string
  sensitive   = true
}