resource "rancher2_machine_config_v2" "ranchmaster" {
  count = var.use_existing_machine_configs ? 0 : 1

  generate_name = "machine-master"

  timeouts {
    create = "20m"
    delete = "20m"
  }

  vsphere_config {
    clone_from        = var.vm_template
    datacenter        = var.datacenter
    folder            = var.folder
    creation_type     = "template"
    cpu_count         = tostring(var.cp_cpu_count)
    memory_size       = tostring(var.cp_memory_mb)
    disk_size         = tostring(var.cp_disk_size_mb)
    network           = var.network
    datastore_cluster = var.datastore_cluster
    pool              = var.pool
    vapp_property     = var.vapp_property
    tags              = var.tags
    cfgparam          = var.cfgparam
    cloud_config      = <<EOF
#cloud-config
runcmd:
  - 'hostnamectl set-hostname $(cloud-init query -a | grep "hostname" | cut -d"\"" -f4)'
  - growpart /dev/sda 2
  - pvresize /dev/sda2
  - lvresize -L 20G /dev/vg_root/lv_root || true
  - xfs_growfs /
  - lvextend -l +100%FREE /dev/vg_root/lv_var || true
  - xfs_growfs /var
EOF
  }

  annotations = {
    git_url      = var.git_url
    git_branch   = var.git_branch
    git_tag      = var.git_tag
    git_commitid = var.git_commitid
  }
}

resource "rancher2_machine_config_v2" "ranchworker" {
  count = var.use_existing_machine_configs ? 0 : 1

  generate_name = "machine-worker"

  timeouts {
    create = "20m"
    delete = "20m"
  }

  vsphere_config {
    clone_from    = var.vm_template
    datacenter    = var.datacenter
    folder        = var.folder
    creation_type = "template"
    cpu_count     = tostring(var.worker_cpu_count)
    memory_size   = tostring(var.worker_memory_mb)
    disk_size     = tostring(var.worker_disk_size_mb)
    network       = var.network
    datastore     = var.datastore
    pool          = var.pool
    vapp_property = var.vapp_property
    tags          = var.tags
    cfgparam      = var.cfgparam
    cloud_config  = <<EOF
#cloud-config
runcmd:
  - 'hostnamectl set-hostname $(cloud-init query -a | grep "hostname" | cut -d"\"" -f4)'
  - growpart /dev/sda 2
  - pvresize /dev/sda2
  - lvresize -L 20G /dev/vg_root/lv_root || true
  - xfs_growfs /
  - lvextend -l +100%FREE /dev/vg_root/lv_var || true
  - xfs_growfs /var
EOF
  }

  annotations = {
    git_url                                              = var.git_url
    git_branch                                           = var.git_branch
    git_tag                                              = var.git_tag
    git_commitid                                         = var.git_commitid
    "cluster.provisioning.cattle.io/autoscaler-min-size" = var.rancher_pool_numworkersmin
    "cluster.provisioning.cattle.io/autoscaler-max-size" = var.rancher_pool_numworkersmax
  }
}
