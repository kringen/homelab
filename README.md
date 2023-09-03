# homelab
Playbooks and Templates to deploy resorces in my home lab

## Ansible
Ansible directory and file structure follows the recommendations here: (Best Practices)[https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html]

# Deploy all playbooks
ansible-playbook -K -i hosts --extra-vars "proxy_admin_username=<username> proxy_admin_password=<password> vm_root_pass=<password>" site.yml

# Tagged Deployments

## DHCPD Deployment
ansible-playbook -K -i hosts --tags dhcpd site.yml

## VIRT Deployment
ansible-playbook -K -i hosts --extra-vars vm_root_pass="<password>" --tags virt site.yml

## BIND Deployment
ansible-playbook -K -i hosts --tags bind site.yml

## NFS Deployment
ansible-playbook -K -i hosts --tags nfs site.yml

## Kubernetes Cluster Deployment
### Deploy the virtual machines using Terraform
```
cd homelab/terraform

TF_VAR_redhat_email=<ReplaceWithRedHatEmail> TF_VAR_redhat_password='<ReplaceWithRealPassword>' TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub) terraform apply -var-file=homelab.tfvars

```
### Install kubernetes and configure cluster using ansible
```
cd homelab/ansible

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --private-key=/home/erik/.ssh/id_rsa -i hosts k8s_cluster.yml -K

```
