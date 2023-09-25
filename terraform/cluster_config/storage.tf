/*
https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner \
    --set nfs.server=10.0.0.10 \
    --set nfs.path=/mnt/nfs/shares

kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
*/

resource "kubernetes_namespace" "storage-provisioner" {
  metadata {
    name = "storage-provisioner"
  }
}


resource "helm_release" "nfs_provisioner" {
  name       = "nfs-subdir-external-provisioner"
  namespace  = kubernetes_namespace.storage-provisioner.metadata[0].name
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner"
  chart      = "nfs-subdir-external-provisioner"

  values = [
    "${file("storage_values.yaml")}"
  ]
  provisioner "local-exec" {
    command = "kubectl patch storageclass nfs-client -p '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"true\"}}}'"
  }
}