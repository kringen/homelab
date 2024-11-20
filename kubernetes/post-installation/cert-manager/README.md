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

# Create a cert-manager Issuer
```
kubectl apply -f clusterissuer.yaml
```

# Create a certificate in istio-system namespace
```
kubectl apply -f certificate.yaml -n istio-system
```

# Troubleshoot
```
istioctl analyze
```

