```
composer-cli sources add ./kubernetes_repo.toml
composer-cli sources add ./docker_repo.toml
composer-cli sources list
composer-cli sources info k8s
```
## Blueprints
```
composer-cli blueprints push kubernetes_node.toml
composer-cli blueprints list
composer-cli blueprints show kubernetes_node
composer-cli blueprints depsolve kubernetes_node
# Export the blueprint
composer-cli blueprints save kubernetes_node
# Edit and push back up after incrementing version - patch version changes automatically
composer-cli blueprints push kubernetes_node.toml
```

# Build Images
```
composer-cli compose start kubernetes_node qcow2
# Check status
composer-cli compose status
# Download by UUID
composer-cli compose image UUID
```

# Test Image
```
TF_VAR_redhat_email=<email> TF_VAR_redhat_password='<password.' TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub) terraform destroy -var-file=test.tfvars
```