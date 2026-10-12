# Kubernetes

This directory contains Kubernetes manifests and configurations for the lab environment.

## Overview

The Kubernetes configurations are used to:
- Deploy applications and services in the Kubernetes cluster
- Configure networking components
- Manage observability tools
- Set up storage solutions
- Configure security and access controls

## Structure

- `certmanager/` - Certificate management configurations
- `csi-driver-nfs/` - NFS CSI driver configuration
- `gatewayapi/` - Gateway API configurations
- `keycloak/` - Keycloak identity management
- `metallb/` - MetalLB load balancer configuration
- `observability/` - Monitoring and logging tools:
  - Prometheus
  - Grafana
  - Loki
  - Tempo
  - Alloy (agent)
- `postgesql/` - PostgreSQL database deployment
- `rbac/` - Role-Based Access Control configurations

## Usage

Deploy manifests using kubectl:
```bash
kubectl apply -f <path-to-manifest>
```

## Rules

- Do not modify the existing Kubernetes cluster unless the task requires it
- Prefer declarative manifests
- Do not reinstall the cluster
- Do not change Kubespray configuration unless explicitly requested