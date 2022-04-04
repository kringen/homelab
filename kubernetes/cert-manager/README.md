# Add helm repo
```
helm repo add jetstack https://charts.jetstack.io
helm repo update
```
# Install Cert Manager
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1 \
  --set installCRDs=true
```