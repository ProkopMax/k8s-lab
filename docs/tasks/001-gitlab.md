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
- HTTPS
- gitlab.k8s.lab
- internal CA
- Ansible Vault for private key
- idempotent role

## Constraints

- Terraform must not be modified.
- Kubernetes must not be modified.
- Host firewall must not be modified.
- Do not recreate the VM.