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

source "qemu" "iso" {
  vm_name              = "ubuntu-2404-amd64.raw"
  iso_url              = "https://releases.ubuntu.com/noble/ubuntu-24.04.1-live-server-amd64.iso"
  iso_checksum         = "e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"
  qemu_binary 	       = "/usr/libexec/qemu-kvm"
  memory               = 1500
  disk_image           = false
  headless             = true
  output_directory     = "build/os-base"
  accelerator          = "kvm"
  disk_size            = "12000M"
  net_bridge           = "virbr0"
  disk_interface       = "virtio"
  format               = "qcow2"
  net_device           = "virtio-net"
  boot_wait            = "3s"
  boot_command         = [
    "e<wait>",
    "<down><down><down><end>",
    " autoinstall ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" ",
    "<f10>"
    ]
  http_directory       = "http"
  shutdown_command     = "echo 'hello' | sudo -S shutdown -P now"
  ssh_username         = "packer"
  ssh_private_key_file = "/home/erik/.ssh/id_rsa"
  ssh_timeout          = "60m"
  ssh_port             = 3434
  vnc_bind_address     = "0.0.0.0"
}

build {
  name    = "iso"
  sources = ["source.qemu.iso"]
}
