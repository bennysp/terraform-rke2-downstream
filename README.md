# terraform-rke2-downstream

Terraform modules for Rancher downstream cluster lifecycle.

## Node Driver Mode

This module supports two machine-config modes:

- Built-in vSphere mode (default): module creates `rancher2_machine_config_v2` resources.
- External machine-config mode: set `use_existing_machine_configs = true` and provide:
	- `rancher_cloud_credential_name`
	- `cp_machine_config_kind`
	- `cp_machine_config_name`
	- `worker_machine_config_kind`
	- `worker_machine_config_name`

Use external mode for custom node drivers (for example Proxmox) where machine configs are created outside this module.

## Modules

- Root module (`//`)

The post module is intentionally hosted in `terraform-rke2-downstream-post`.

Terragrunt is intentionally kept as the orchestration layer:

- `terragrunt-units-rancher` wires module inputs/outputs.
- `terragrunt-stacks-rancher` controls ordering and composition.
- `terragrunt-rancher-cluster` provides environment-specific values.