# Build the image
```
sudo su
packer init
export PACKER_LOG=1 && packer build ubuntu_node.pkr.hcl
```