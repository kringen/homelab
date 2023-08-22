
///////////////// kringlab01 host ///////////////////

provider "libvirt" {
  uri = "qemu+ssh://10.0.0.10/system"
  alias = "kringlab01"
}

# Base OS image to use to create a cluster of different nodes
resource "libvirt_volume" "rhel8_base" {
  provider = libvirt.kringlab01
  name   = "rhel8_base"
  source = "/var/lib/libvirt/images/rhel-8.5-x86_64-kvm.qcow2"
}

resource "libvirt_volume" "qcow_volume" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  provider = libvirt.kringlab01
  name = "${each.value.name}.img"
  pool = "default"
  base_volume_id = libvirt_volume.rhel8_base.id
}

data "template_file" "user_data" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  template = file("${path.module}/cloud_init.cfg")

  vars = {
   hostname = each.value.name
   domain = each.value.domain
   ssh_public_key = var.ssh_public_key
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  provider = libvirt.kringlab01
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  name           = "${each.value.name}-init.iso"
  user_data      = data.template_file.user_data[each.key].rendered
  pool           = "default"
}

# Define KVM domain to create
resource "libvirt_domain" "kvm_domain" {
  provider = libvirt.kringlab01
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  name   = each.value.name
  memory = each.value.memory
  vcpu   = each.value.cpu

  cloudinit = libvirt_cloudinit_disk.commoninit[each.key].id

  disk {
    volume_id = libvirt_volume.qcow_volume[each.key].id
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
    addresses      = [each.value.ip]
    macvtap        = each.value.bridge
    wait_for_lease = false
  }
}