variable "cluster_name" {
  description = "Logical downstream cluster name."
  type        = string
  default     = "rancher-cluster"
}

variable "rancher_cluster_name" {
  description = "Legacy cluster name input. If set, it is used when cluster_name is empty."
  type        = string
  default     = ""
}

variable "vaultpath_vsphere" {
  type    = string
  default = "secret/vsphere/auth"
}

variable "vaultpath_linux" {
  type    = string
  default = "secret/linux/ubuntu_auth"
}

variable "vaultpath_github" {
  type    = string
  default = "secret/github/creds"
}

variable "vaultpath_mikrotik" {
  type    = string
  default = "secret/mikrotik/creds"
}

variable "vaultpath_rancher_local" {
  type    = string
  default = "secret/rancher/clusters/local"
}

variable "vault_ca_path" {
  type    = string
  default = "pki/cert/ca"
}

variable "git_url" {
  type    = string
  default = ""
}

variable "git_branch" {
  type    = string
  default = ""
}

variable "git_tag" {
  type    = string
  default = ""
}

variable "git_commitid" {
  type    = string
  default = ""
}

variable "s3_region" {
  type    = string
  default = "us-east-1"
}

variable "s3_endpoint" {
  type    = string
  default = "nasserv02.domain.thedaily.tv:9000"
}

variable "rke2_version" {
  type    = string
  default = "v1.33.1+rke2r1"
}

variable "rancher_url" {
  type    = string
  default = "https://rancher.domain.thedaily.tv"
}

variable "endpoint_dns" {
  type    = string
  default = "downstream.domain.thedaily.tv"
}

variable "rancher_docker_engine_url" {
  type    = string
  default = "https://releases.rancher.com/install-docker/20.10.sh"
}

variable "rancher_pool_numcps" {
  type    = number
  default = 1
}

variable "rancher_pool_numworkersmin" {
  type    = number
  default = 3
}

variable "rancher_pool_numworkersmax" {
  type    = number
  default = 3
}

variable "rancher_cloud_credential_name" {
  description = "Rancher cloud_credential_secret_name value used by downstream machine pools (for example cattle-global-data:vcenter-cred)."
  type        = string
  default     = "vcenter-cred"
}

variable "use_existing_machine_configs" {
  description = "If true, reuse externally managed machine configs by kind/name instead of creating vSphere configs in this module."
  type        = bool
  default     = false
}

variable "cp_machine_config_kind" {
  description = "Machine config kind for control-plane pool when use_existing_machine_configs is true (for example PveConfig)."
  type        = string
  default     = ""
}

variable "cp_machine_config_name" {
  description = "Machine config name for control-plane pool when use_existing_machine_configs is true."
  type        = string
  default     = ""
}

variable "worker_machine_config_kind" {
  description = "Machine config kind for worker pool when use_existing_machine_configs is true (for example PveConfig)."
  type        = string
  default     = ""
}

variable "worker_machine_config_name" {
  description = "Machine config name for worker pool when use_existing_machine_configs is true."
  type        = string
  default     = ""
}

variable "machine_config_api_version" {
  description = "API version for machine_config block in cluster_v2 machine pools."
  type        = string
  default     = "rke-machine-config.cattle.io/v1"
}

variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config.downstream"
}

variable "nexus_registry" {
  type    = string
  default = "https://nexus-registry.ta.domain.thedaily.tv:8444/"
}

variable "vcenter_host" {
  type    = string
  default = "vcenter.domain.thedaily.tv"
}

variable "datacenter" {
  type    = string
  default = "/HOME"
}

variable "folder" {
  type    = string
  default = "/HOME/vm"
}

variable "datastore" {
  type    = string
  default = "/HOME/datastore/datastore-nfs002"
}

variable "datastore_cluster" {
  type    = string
  default = "/HOME/datastore/DatastoreCluster"
}

variable "pool" {
  type    = string
  default = "/HOME/host/cluster01/Resources"
}

variable "network" {
  type = list(string)
  default = [
    "/HOME/network/k8s-int-10",
  ]
}

variable "cfgparam" {
  type    = list(any)
  default = ["disk.EnableUUID=TRUE"]
}

variable "tags" {
  type    = list(any)
  default = []
}

variable "vapp_property" {
  type    = list(any)
  default = []
}

variable "vm_template" {
  type    = string
  default = "/HOME/vm/Templates/rockylinux-packer/template-rockylinux9"
}

variable "cp_cpu_count" {
  description = "Control-plane VM vCPU count for generated machine config."
  type        = number
  default     = 8
}

variable "cp_memory_mb" {
  description = "Control-plane VM memory size in MB for generated machine config."
  type        = number
  default     = 16384
}

variable "cp_disk_size_mb" {
  description = "Control-plane VM disk size in MB for generated machine config."
  type        = number
  default     = 40960
}

variable "worker_cpu_count" {
  description = "Worker VM vCPU count for generated machine config."
  type        = number
  default     = 8
}

variable "worker_memory_mb" {
  description = "Worker VM memory size in MB for generated machine config."
  type        = number
  default     = 8192
}

variable "worker_disk_size_mb" {
  description = "Worker VM disk size in MB for generated machine config."
  type        = number
  default     = 102400
}

variable "delaysec" {
  type    = string
  default = "360"
}

variable "mt_host" {
  type    = string
  default = "192.168.10.1:8728"
}

variable "mt_bpg_instance" {
  type    = string
  default = "bgp-rancher"
}

variable "mt_bpg_port" {
  type    = string
  default = "64512"
}

variable "mt_bpg_id" {
  type    = string
  default = "192.168.10.1"
}

variable "k8s_host" {
  type    = string
  default = ""
}

variable "k8s_ca" {
  type    = string
  default = ""
}

variable "k8s_token_jwt" {
  type    = string
  default = ""
}

variable "k8s_serviceaccount" {
  type    = string
  default = ""
}

variable "vault_dns" {
  type    = string
  default = "vault.domain.thedaily.tv"
}

variable "minio_server" {
  type    = string
  default = "nasserv02.domain.thedaily.tv:9000"
}

variable "minio_region" {
  type    = string
  default = "us-east-1"
}

variable "MINIO_ACCESS_KEY" {
  type    = string
  default = ""
}

variable "MINIO_SECRET_KEY" {
  type      = string
  default   = ""
  sensitive = true
}
