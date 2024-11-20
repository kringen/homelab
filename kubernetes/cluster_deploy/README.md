# Build the node image using Packer
```
cd ../../packer/k8s_node_ubuntu
sudo su
packer init ubuntu_node.pkr.hcl
export PACKER_LOG=1 && packer build ubuntu_node.pkr.hcl
```
# Deploy the nodes
```
# Change back to this directory
cd ../../kubernetes/cluster_deploy
terraform init
TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub) terraform apply -var-file=homelab.tfvars
```
# Initialize the cluster and network CNI
```
```
# Post-Install Configuration 
```
```
