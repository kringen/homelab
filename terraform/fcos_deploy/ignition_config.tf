# Ignition file generation

data "ignition_file" "hostname" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm }
  path       = "/etc/hostname"
  mode       = "420" // 0644
  content {
    content = templatefile("${path.module}/templates/etc_hostname.tmpl", {
      hostname = each.value.name
      domain = each.value.domain
    })
  }
}

data "ignition_user" "core" {
    name = "core"
    home_dir = "/home/core/"
    shell = "/bin/bash"
    ssh_authorized_keys = [var.ssh_public_key]
    groups = ["sudo", "docker", "wheel", "adm", "systemd-journal"]
}

data "ignition_user" "local_user" {
    name = var.local_user
    home_dir = "/home/erik/"
    shell = "/bin/bash"
    ssh_authorized_keys = [var.ssh_public_key]
    groups = ["sudo", "docker", "wheel", "adm", "systemd-journal"]
}

data "ignition_config" "ignition" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm }
  users   = [data.ignition_user.core.rendered, data.ignition_user.local_user.rendered]
  files   = [data.ignition_file.hostname[each.key].rendered]
}