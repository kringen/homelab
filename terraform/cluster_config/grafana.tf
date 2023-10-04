resource "kubernetes_namespace" "grafana" {
  metadata {
    annotations = {
      name = "grafana"
    }
    name = "grafana"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.grafana.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"

  depends_on = [ kubernetes_namespace.grafana ]
}

/*
Check Installation

1. Get the application URL by running these commands:
    echo "Browse to http://127.0.0.1:8080"
    kubectl port-forward svc/grafana 8080:3000 &

2. Get the admin credentials:

    echo "User: admin"
    echo "Password: $(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"

*/