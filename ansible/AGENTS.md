# AI Agent Instructions

## Project

This is a local Kubernetes infrastructure lab.

Infrastructure:
- Terraform manages libvirt VMs.
- Ansible configures operating systems and applications in the VMs.
- Kubespray manages Kubernetes.
- Host firewall is managed manually and MUST NOT be changed by Ansible.

## Terraform rules

- Use for_each for VM resources.
- Do not replace existing Kubernetes VMs unless explicitly requested.
- Do not destroy or recreate control-plane nodes without explicit confirmation.
- Do not modify Terraform state manually unless necessary.
- Never run terraform apply automatically.
- Always inspect terraform plan before applying changes.
- Never commit terraform.tfstate.
- Never commit secrets or passwords.

## Kubernetes rules

- Do not modify the existing Kubernetes cluster unless the task requires it.
- Prefer declarative manifests.
- Do not reinstall the cluster.
- Do not change Kubespray configuration unless explicitly requested.

## Ansible rules

- Use roles.
- Keep secrets in Ansible Vault.
- Make tasks idempotent.
- Do not manage the host firewall.

## Workflow

Before changing files:
1. Inspect the existing implementation.
2. Explain the proposed changes.
3. Make the smallest necessary changes.
4. Run syntax/configuration validation.
5. Show the diff.
6. Do not apply destructive changes without confirmation.