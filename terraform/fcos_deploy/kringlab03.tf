
///////////////// kringlab03 host ///////////////////

provider "libvirt" {
  uri = "qemu+ssh://10.0.0.30/system"
  alias = "kringlab03"
}

# Base OS image to use to create a cluster of different nodes
resource "libvirt_volume" "rhel8_base_03" {
  provider = libvirt.kringlab03
  name   = "rhel8_base"
  source = var.base_image
}

resource "libvirt_volume" "qcow_volume_03" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab03" }
  provider = libvirt.kringlab03
  name = "${each.value.name}.img"
  pool = "default"
  base_volume_id = libvirt_volume.rhel8_base_03.id
  size = 20 * 1024 * 1024 * 1024 # 20GiB. the root FS is automatically resized by cloud-init growpart (see https://cloudinit.readthedocs.io/en/latest/topics/examples.html#grow-partitions).

}

resource "libvirt_cloudinit_disk" "commoninit_03" {
  provider = libvirt.kringlab03
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab03" }
  name           = "${each.value.name}-init.iso"
  user_data      = data.template_file.user_data[each.key].rendered
  pool           = "default"
}

# Define KVM domain to create
resource "libvirt_domain" "kvm_domain_03" {
  provider = libvirt.kringlab03
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab03" }
  name   = each.value.name
  memory = each.value.memory
  vcpu   = each.value.cpu

  cloudinit = libvirt_cloudinit_disk.commoninit_03[each.key].id

  disk {
    volume_id = libvirt_volume.qcow_volume_03[each.key].id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }

  network_interface {
    mac            = each.value.mac
    macvtap        = each.value.bridge
    wait_for_lease = false
  }
}
