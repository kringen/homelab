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