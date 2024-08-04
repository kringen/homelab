# Installing Providers
## Prerequisites on Host Machines
```
sudo usermod -a -G libvirt $(whoami)
sudo usermod -a -G kvm $(whoami)
```
## libvirt provider
https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs


# Create cluster
```
TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub) terraform apply -var-file=homelab.tfvars
```
