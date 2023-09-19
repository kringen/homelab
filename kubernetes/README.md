# Cluster Post-Deploy Setup

## 1 - Deploy MetalLB
```
# https://metallb.universe.tf/tutorial/layer2/

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.11/config/manifests/metallb-native.yaml

kubectl apply -f ./metallb/layer2-config.yaml
```

## 2 - Install Service Mesh
```
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
sudo cp bin/istioctl /usr/local/bin
istioctl install --set profile=default -y
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```

## Enable AAD IAM using OIDC

### Get release and download linux/amd64: https://github.com/int128/kubelogin/releases/tag/v1.28.0
```
sudo cp kubelogin /usr/local/bin
```
### Set environment variables for Azure Application
Client specs:
* Redirect Type: Web, URI: http://localhost:8000 and http://localhost:18000
* Token configuration: Add groups claim: Security Groups, Other claim: email

CLIENT_ID=""
CLIENT_SECRET=""
TENANT_ID="" 

### Test out token generation
kubelogin get-token \
  --oidc-issuer-url=https://sts.windows.net/${TENANT_ID}/ \
  --oidc-client-id=${CLIENT_ID} \
  --oidc-client-secret="${CLIENT_SECRET}" \
  --oidc-extra-scope="email groups"


### Create User Context
```
kubectl config set-credentials aad \
  --exec-api-version=client.authentication.k8s.io/v1beta1 \
  --exec-command=kubelogin \
  --exec-arg=get-token \
  --exec-arg=--oidc-issuer-url=https://sts.windows.net/b021ce92-4160-4e98-9d09-d4f7d27159e1/ \
  --exec-arg=--oidc-client-id=53225173-1f54-4b33-861a-36e1031a4aa7 \
  --exec-arg=--oidc-client-secret="Rt28Q~l4GsgiAR4xzP3sWRX.PknD5i0Rspqz7bro" \
  --exec-arg=--oidc-extra-scope="email groups"
```

### Log onto each control plane node and edit /etc/kubernetes/manifests/kube-apiserver.yaml
Add the following to extraArgs:
```yaml
    - --oidc-client-id=<client_id_goes_here>
    - --oidc-groups-claim=groups
    - --oidc-groups-prefix=
    - --oidc-issuer-url=https://sts.windows.net/<tenant_id_goes_here>/
    - --oidc-username-claim=email
```

```
sudo kubeadm upgrade node

```

### Create cluster role binding
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: aad-cluster-admins
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: "8963f4a8-df40-4c1e-9e84-1325788dba11"
```

### To logout of the cluster
```
rm -rf ~/.kube/cache/oidc-login/
```

## Install NFS Storage Class Provisioner
Documentation can be found here: https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner \
    --set nfs.server=10.0.0.10 \
    --set nfs.path=/mnt/nfs/shares

kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

## Install Cert Manager
### Add helm repo
```
helm repo add jetstack https://charts.jetstack.io
helm repo update
```
### Install Cert Manager
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1 \
  --set installCRDs=true
```

### Create a cert-manager Issuer
```
kubectl apply -f clusterissuer.yaml
```

### Create a certificate in istio-system namespace
```
kubectl apply -f certificate.yaml -n istio-system
```

## Install Prometheus/Grafana

## Install Kyverno Policy Engine
```
helm repo add kyverno https://kyverno.github.io/kyverno/

helm repo update

helm install kyverno-policies kyverno/kyverno-policies -n kyverno

```

## Install Argo-CD GitOps


