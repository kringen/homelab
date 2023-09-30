# Post-Deployment Kubernetes Configuration using Terraform
These terraform configs will install essential configurations / applications such as:
* Service Mesh
* Certificate Manager
* NFS Storage Class
* OpenID Connect (OIDC) Authentication
* Roles & RoleBindings

# Usage
```
cd homelab/terraform/cluster_config

terraform apply -var-file=variable.tfvars
```
