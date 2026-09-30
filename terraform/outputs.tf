output "ansible_inventory_path" {
  value = local_file.ansible_inventory.filename
}

output "kubespray_inventory_path" {
  value = local_file.kubespray_inventory.filename
}