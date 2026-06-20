# terraform-rke2-downstream

Terraform modules for Rancher downstream cluster lifecycle.

## Modules

- Root module (`//`)

The post module is intentionally hosted in `terraform-rke2-downstream-post`.

Terragrunt is intentionally kept as the orchestration layer:

- `terragrunt-units-rancher` wires module inputs/outputs.
- `terragrunt-stacks-rancher` controls ordering and composition.
- `terragrunt-rancher-cluster` provides environment-specific values.