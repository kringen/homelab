# Installing Providers
## Prerequisites on Host Machines
```
sudo usermod -a -G libvirt $(whoami)
sudo usermod -a -G kvm $(whoam)
```
## libvirt provider
https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs

## Environment Variables
export TF_VAR_ssh_public_key1=""
