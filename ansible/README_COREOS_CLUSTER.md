Run script to export app variables
```
source <script to export variables>
```
Execute ansible-playbook
```
ansible-playbook -i hosts k8s_cluster_coreos.yml --extra-vars="oidc_client_id=${KUBELOGIN_APP_ID} oidc_tenant_id=${KUBELOGIN_APP_TENANT_ID}"
```