# Installing Providers
## Prerequisites on Host Machines
```
sudo usermod -a -G libvirt $(whoami)
sudo usermod -a -G kvm $(whoami)
```
## libvirt provider
https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs


## Custom cloud-init images:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_cloud-init_for_rhel_8/configuring-cloud-init_cloud-content

# Create cluster
```
TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub) terraform apply -var-file=homelab.tfvars
```
