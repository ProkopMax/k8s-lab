# Task 001 — Optimize GitLab CE Omnibus Ansible Role

## 1. Goal

Review, optimize, and improve the existing Ansible role `gitlab-ce` for a small, resource-constrained GitLab CE Omnibus instance used in the `k8s-lab` environment.

The objective is to maintain a reliable Git repository and GitLab application while minimizing memory consumption, unnecessary background services, and disk usage.

Work in two phases:

1. Inspect the existing project and prepare an implementation plan.
2. Implement the approved changes, validate the role, and document the results.

Do not rewrite the role from scratch unless the existing implementation is fundamentally unsuitable.

## 2. Current Infrastructure

Terraform has already provisioned the following VM:

- Hostname: `gitlab-01`
- IP address: `192.168.122.104`
- vCPU: 2
- RAM: 8 GB
- Disk: 80 GB
- Domain: `gitlab.k8s.lab`

The existing Ansible role is named `gitlab-ce`.

## 3. Intended Use

This instance is intended for a small personal DevOps lab.

Required functionality:

- Git repository hosting.
- GitLab web interface over HTTPS.
- User, project, and repository management.
- PostgreSQL database managed by Omnibus.
- Redis and the background processing services required by GitLab.
- Gitaly for Git repository storage.
- GitLab API and Git-over-HTTPS access.
- Integration with a GitLab Runner deployed separately in Kubernetes.

GitLab Runner must not be installed or managed by this role.

CI/CD jobs will execute in Kubernetes using the Kubernetes executor.

Do not disable core GitLab services required for the functionality listed above.

## 4. Resource Optimization

Review and optimize `/etc/gitlab/gitlab.rb` through Ansible-managed configuration.

Requirements:

- Reduce memory consumption and unnecessary background processing.
- Configure Puma for a low-resource, low-concurrency installation.
- Reduce Sidekiq concurrency to a conservative, supported value.
- Review PostgreSQL and Redis resource consumption.
- Disable bundled monitoring services and exporters that are not needed by this lab.
- Disable optional services and integrations that are not required by the intended use.
- Review GitLab KAS, GitLab Pages, registry, and other optional components before disabling them.
- Keep all required GitLab application, database, repository, and background-processing services enabled.
- Avoid aggressive settings that make GitLab unstable or prevent upgrades.
- Prefer documented GitLab Omnibus configuration parameters.
- Make resource-related settings configurable through Ansible variables.

Do not disable features solely because their names suggest they are optional. Explain the impact of each proposed change.

Provide a short list of enabled and disabled services and the reason for each decision.

## 5. HTTPS and TLS

Configure GitLab to use:

`https://gitlab.k8s.lab`

Certificate:

`certs/gitlab/gitlab.k8s.lab.crt`

Private key:

`certs/private/tls.key`

Requirements:

- Use the existing certificate and private key.
- Do not generate a replacement certificate or private key.
- Do not overwrite or modify the supplied certificate.
- Store the private key in Ansible Vault-encrypted form.
- Never print private key contents or Vault secrets in logs.
- Ensure appropriate file ownership and permissions on the target VM.
- Validate the certificate and private key before applying the configuration.
- Configure Omnibus HTTPS and ensure GitLab uses the correct hostname.
- Ensure GitLab does not serve the application over unencrypted HTTP unless explicitly required for a documented redirect or health check.
- Verify certificate validity, hostname coverage, and the certificate chain where applicable.
- Document any prerequisite for trusting the issuing CA on clients and Kubernetes Runner pods.

The role must not assume that a certificate issued by a private CA is automatically trusted by all clients.

## 6. Ansible Role Quality

The role must be idempotent.

Requirements:

- Use variables for hostname, external URL, certificate paths, and resource-related configuration.
- Keep secrets out of plaintext defaults, templates, and task output.
- Use Ansible Vault for the private key or other secret material.
- Use handlers for configuration changes and service reload/reconfiguration.
- Run `gitlab-ctl reconfigure` only when relevant managed configuration changes.
- Avoid unnecessary service restarts.
- Use handlers or explicit tasks to restart only the required services when supported.
- Validate configuration files and certificates before applying changes where practical.
- Use `no_log: true` on tasks that could expose sensitive material.
- Ensure file and directory permissions are correct.
- Do not use shell commands where a suitable Ansible module is available.
- Make package installation and configuration safe to run repeatedly.

A second execution of the role without changes should report no unintended changes.

## 7. Disk Usage and Persistence

Review disk usage for the 80 GB VM.

- Identify the directories used for Git repositories, uploads, application data, logs, and PostgreSQL.
- Avoid unnecessary log and cache growth.
- Configure sensible log rotation and retention where supported.
- Do not delete repository data, uploads, or database files.
- Do not move GitLab data directories as part of this task.
- Document disk usage and backup considerations.
- Do not claim that GitLab data is backed up unless a working backup procedure is implemented and tested.

## 8. Strict Constraints

- Do not modify Terraform files or Terraform-managed infrastructure.
- Do not recreate, replace, or destroy the existing VM.
- Do not modify Kubernetes manifests, cluster configuration, or Kubernetes resources.
- Do not modify host firewall rules or networking configuration.
- Do not change the VM IP address or hostname.
- Do not change the existing DNS configuration.
- Do not install GitLab Runner on the VM.
- Do not replace the existing TLS certificate or private key.
- Do not remove existing GitLab data.
- Do not perform destructive database, repository, or storage operations.

Only modify the Ansible role and its directly related configuration, variables, templates, handlers, tests, and documentation.

## 9. Implementation Workflow

### Phase 1 — Inspect and Plan

Before editing files:

1. Read the root `AGENTS.md` and `README.md`.
2. Read `ansible/AGENTS.md` and `ansible/README.md`, if present.
3. Inspect the entire existing `gitlab-ce` role, including defaults, variables, tasks, handlers, templates, and dependencies.
4. Inspect the relevant inventory and playbooks without exposing secrets.
5. Identify the current GitLab version and existing configuration where safely accessible.
6. Identify which services are enabled and which settings are already managed by Ansible.
7. Identify conflicts, duplicated configuration, unsafe defaults, and non-idempotent tasks.
8. Produce a proposed change list before implementation.

Do not make infrastructure changes during the inspection phase.

### Phase 2 — Implement and Validate

After completing the inspection:

1. Implement the agreed optimization.
2. Update role defaults and templates consistently.
3. Add or update handlers as needed.
4. Update documentation and example variables.
5. Run YAML syntax validation and Ansible linting where available.
6. Run a check-mode or equivalent safe validation where supported.
7. Execute the role against the existing VM only after reviewing the proposed changes.
8. Run the role a second time and inspect idempotency.
9. Verify GitLab health, HTTPS, certificate configuration, and repository access.
10. Verify that the GitLab Runner can be integrated from Kubernetes without installing Runner on the VM.

Do not assume that check mode fully validates GitLab Omnibus reconfiguration.

## 10. Acceptance Criteria

The task is complete when:

- The existing VM remains unchanged in identity, IP address, and lifecycle.
- The supplied certificate and private key are used correctly.
- The private key is protected by Ansible Vault and never exposed in logs.
- PostgreSQL, Redis, Gitaly, Puma, Sidekiq, and other required components remain operational.
- Unnecessary bundled monitoring services are disabled where appropriate.
- Resource tuning is documented and configurable.
- Repository creation, cloning, and Git-over-HTTPS access work.
- The role passes syntax validation.
- A second Ansible run produces no unintended changes.
- Terraform, Kubernetes, host firewall rules, DNS, and VM lifecycle remain untouched.
- Documentation describes the configuration, service decisions, validation steps, and known limitations.

## 11. Final Report

At completion, provide:

- Summary of the original role and its issues.
- Files changed and why.
- Services disabled and the reason for each.
- Resource tuning values and their expected impact.
- TLS and Ansible Vault implementation details without revealing secrets.
- Validation commands and actual results.
- Idempotency test results.
- Remaining risks and recommended follow-up tasks.