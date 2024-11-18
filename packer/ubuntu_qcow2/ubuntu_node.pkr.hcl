packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

source "qemu" "template" {
  vm_name              = "ubuntu-2404-amd64.qcow2"
  iso_url              = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  iso_checksum         = "5dc7f9c796442a51316d8431480fbe3f62cadbfde4d58a14d34dd987c01fd655"
  qemu_binary 	       = "/usr/libexec/qemu-kvm"
  memory               = 1500
  headless             = true
  output_directory     = "build/node"
  accelerator          = "kvm"
  disk_size            = "12000M"
  net_bridge           = "virbr0"
  disk_interface       = "virtio"
  disk_image           = true
  format               = "qcow2"
  net_device           = "virtio-net"
  boot_wait            = "30s"
  cd_files = ["cloud-init/user-data", "cloud-init/meta-data"]
  cd_label = "cidata"
  use_backing_file     = false
  shutdown_command     = "sudo shutdown -P now"
  ssh_username         = "ubuntu"
  ssh_private_key_file = "/home/erik/.ssh/id_rsa"
  ssh_timeout          = "60m"
  #ssh_port             = 3434
  vnc_bind_address     = "0.0.0.0"
  qemuargs = [
    ["-serial", "mon:stdio"],
  ]
}

build {
  name    = "template"
  sources = ["source.qemu.template"]
  # wait for cloud-init to successfully finish
  provisioner "shell" {
    inline = [
      "cloud-init status --wait > /dev/null 2>&1"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "ansible/playbook.yml"
    role_paths    = ["ansible/roles/common"]
  }
}
