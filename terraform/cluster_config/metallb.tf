# https://metallb.universe.tf/tutorial/layer2/

# cd manifests && wget https://raw.githubusercontent.com/metallb/metallb/v0.13.11/config/manifests/metallb-native.yaml

data "kubectl_file_documents" "metallb-native" {
  content = file("./manifests/metallb-native.yaml")
}

resource "kubectl_manifest" "metallb" {
  count     = length(data.kubectl_file_documents.metallb-native.documents)
  yaml_body = element(data.kubectl_file_documents.metallb-native.documents, count.index)
}

resource "kubectl_manifest" "layer2" {
  yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 10.0.0.40/28
YAML

depends_on = [ kubectl_manifest.metallb ]
}

resource "kubectl_manifest" "l2advertisement"{
  yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: example
  namespace: metallb-system
    YAML
  depends_on = [ kubectl_manifest.metallb ]
}
