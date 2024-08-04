
///////////////// kringlab01 host ///////////////////

provider "libvirt" {
  uri = "qemu+ssh://10.0.0.10/system"
  alias = "kringlab01"
}

# Base OS image to use to create a cluster of different nodes
resource "libvirt_volume" "base_01" {
  provider = libvirt.kringlab01
  name   = "base_image_fcos.qcow2"
  source = var.base_image
}

resource "libvirt_volume" "qcow_volume_01" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  provider = libvirt.kringlab01
  name = "${each.value.name}.img"
  pool = "default"
  base_volume_id = libvirt_volume.base_01.id
  size = 20 * 1024 * 1024 * 1024 # 20GiB. the root FS is automatically resized by cloud-init growpart (see https://cloudinit.readthedocs.io/en/latest/topics/examples.html#grow-partitions).

}

resource "libvirt_ignition" "ignition" {
  provider = libvirt.kringlab01
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  name           = "${each.value.name}-init.iso"
  content = data.template_file.ignition_template[each.key].rendered
}

# Define KVM domain to create
resource "libvirt_domain" "kvm_domain_01" {
  provider = libvirt.kringlab01
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm if vm.host == "kringlab01" }
  name   = each.value.name
  memory = each.value.memory
  vcpu   = each.value.cpu
  autostart = true

  coreos_ignition = libvirt_ignition.ignition[each.key].id

  disk {
    volume_id = libvirt_volume.qcow_volume_01[each.key].id
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
