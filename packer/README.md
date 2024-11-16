# Install
```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install packer
```

# Build Image
Create a directory for cloud-init and create an empty meta-data file.  Create a user-data file
```
mkdir -p cloud-init
touch cloud-init/meta-data
vim cloud-init/user-data
```
```
sudo packer init <path_to_definition_file>
sudo packer build <path_to_definition_file>
```
