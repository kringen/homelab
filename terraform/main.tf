variable "vm_name" {
  type = string
  default = "my-test-vm"
}

variable "domain" {
  type = string
  default = "example.com"
}

variable "memory" {
  type = string
  default = "2048"
}

variable "cpu" {
  type = number
  default = 2
}

provider "libvirt" {
  uri = "qemu+ssh://10.0.0.10/system"
}


resource "libvirt_volume" "qcow_volume" {
  name = "${var.vm_name}.img"
  pool = "default"
  source = "/var/lib/libvirt/rhel-9.2-x86_64-kvm.qcow2"
  format = "qcow2"
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")

  vars = {
   hostname = var.vm_name
   domain = var.domain
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  pool           = "default"
}

# Define KVM domain to create
resource "libvirt_domain" "kvm_domain" {
  name   = var.vm_name
  memory = var.memory
  vcpu   = var.cpu

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  disk {
    volume_id = libvirt_volume.qcow_volume.id
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
    hostname       = "mytestvm"
    mac            = "52:54:00:f2:1e:69"
    addresses      = ["10.0.0.125"]
    //bridge         =  "virbr0"
    macvtap        = "enp6s0"
    wait_for_lease = false
  }
}

output "ip" {
  value = libvirt_domain.kvm_domain.network_interface.0.addresses.0
}
