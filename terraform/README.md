# Terraform

This directory contains Terraform configurations for provisioning the infrastructure in the Kubernetes lab.

## Overview

The Terraform configuration is used to:
- Provision libvirt VMs for the Kubernetes cluster
- Configure network settings
- Manage VM resources and volumes

## Structure

- `vm.tf` - VM definitions using for_each
- `network.tf` - Network configuration
- `volumes.tf` - Volume definitions
- `variables.tf` - Input variables
- `terraform.tfvars` - Variable values
- `templates/` - Template files used in provisioning
  - `inventory.ini.tftpl` - Inventory template for Ansible
  - `kubespray-inventory.ini.tftpl` - Kubespray inventory template
  - `network-config.yaml.tftpl` - Network configuration template
  - `user-data.yaml.tftpl` - Cloud-init user data template

## Usage

To use the Terraform configuration:

1. Initialize:
```bash
terraform init
```

2. Plan changes:
```bash
terraform plan
```

3. Apply changes:
```bash
terraform apply
```

## Rules

- Use for_each for VM resources
- Do not replace existing Kubernetes VMs unless explicitly requested
- Do not destroy or recreate control-plane nodes without explicit confirmation
- Do not modify Terraform state manually unless necessary
- Never run terraform apply automatically
- Always inspect terraform plan before applying changes
- Never commit terraform.tfstate
- Never commit secrets or passwords