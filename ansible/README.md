# GitLab CE Omnibus Installation

This project contains Ansible playbooks and roles for installing GitLab CE Omnibus on Ubuntu servers.

## Structure

- `roles/gitlab-ce/` - Role for installing and configuring GitLab CE
  - `defaults/main.yml` - Default variables for GitLab installation
  - `tasks/main.yml` - Main tasks for GitLab installation
  - `handlers/main.yml` - Handlers for GitLab reconfiguration
  - `templates/gitlab.rb.j2` - Configuration template for GitLab

- `install-gitlab.yml` - Playbook to install GitLab CE on a server
- `setup-gitlab-server.yml` - Playbook to setup a complete GitLab server (base + gitlab-ce)

## Usage

1. Ensure your inventory.ini contains a host group [gitlab-server] with your GitLab server details
2. Run the setup playbook:
   ```bash
   ansible-playbook setup-gitlab-server.yml
   ```

## Variables

The following variables can be customized in `roles/gitlab-ce/defaults/main.yml`:

- `gitlab_version`: Version of GitLab to install
- `gitlab_external_url`: External URL for GitLab
- `gitlab_time_zone`: Time zone for GitLab
- `gitlab_backup_keep_time`: Backup retention time
- `gitlab_admin_password`: Initial admin password (will be set during installation)