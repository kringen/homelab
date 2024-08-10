terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    },
    ignition = {
      source = "community-terraform-providers/ignition"
      version = "2.3.5"
    }
  }
}