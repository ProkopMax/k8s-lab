# Task 001 — GitLab CE

## Goal

Optimization asnible role gitlab-ce.

## Current state

Terraform already created vm:

- gitlab-01
- 192.168.122.104
- 2 CPU
- 8 GB RAM
- 80 GB disk

Ansible role created:
- gitlab-ce

## Requirements

- Optimization GitLab Omnibus configuration for vm
- GitLab web interface over HTTPS url https://gitlab.k8s.lab
- domain gitlab.k8s.lab
- Use ceritificate in certs/gitlab/gitlab.k8s.lab.crt and private key in certs/private/tls.key
- Ansible Vault for private key
- GitLab Runner must not be installed or managed by this role.
- Redis and the background processing services required by GitLab.
- PostgreSQL database managed by Omnibus.
- User, project, and repository management.
- idempotent role

## Constraints

- Terraform must not be modified.
- Kubernetes must not be modified.
- Host firewall must not be modified.
- Do not recreate the VM.