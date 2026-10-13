# Ansible

This directory contains Ansible playbooks and roles for configuring the infrastructure in the Kubernetes lab.

## Overview

The Ansible configuration is used to:
- Configure operating systems on VMs
- Install and configure applications on VMs
- Manage system services and settings

## Structure

- `roles/` - Contains reusable Ansible roles for different components
- `group_vars/` - Group variable definitions
- `inventory.ini` - Inventory file defining hosts and groups
- Playbooks:
  - `prepare-nodes.yml` - Prepare nodes for Kubernetes deployment
  - `configure-time.yml` - Configure time synchronization
  - `install-gitlab.yml` - Install GitLab CE
  - `setup-gitlab-server.yml` - Setup GitLab server configuration

## Usage

To run a playbook:
```bash
ansible-playbook -i inventory.ini <playbook-name>.yml --ask-vault-pass -k
```

## Rules

- Use roles for organizing code
- Keep secrets in Ansible Vault
- Make tasks idempotent
- Do not manage the host firewall

## GitLab Configuration

GitLab is configured with:
- HTTPS access at https://gitlab.k8s.lab
- SSL certificate from certs/gitlab/gitlab.k8s.lab.crt
- Private key stored in Ansible Vault (vault_gitlab_ssl_key variable)
- GitLab Runner disabled