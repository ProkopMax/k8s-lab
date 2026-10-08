# Task 001 — Base

## Goal

Add task update ca certificate to the asnible role base.

## Current state

Ansible role created:
- base

## Requirements

- copy certificate from certs/ca/k8s-lab-root-ca.crt to vms
- update this cert
- idempotent role

## Constraints

- Terraform must not be modified.
- Kubernetes must not be modified.
- Host firewall must not be modified.
- Do not recreate the VM.