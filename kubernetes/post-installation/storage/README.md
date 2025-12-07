# Install an NFS provisioner on the cluster.

https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/


kubectl create ns storage

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner -n storage \
    --set nfs.server=kringlab01 \
    --set nfs.path=/mnt/nfs/shares

kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

The provision PVC to test:

All nodes need to install nfs-common package
```
apt install nfs-common
```

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
spec:
  storageClassName: nfs-client
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi