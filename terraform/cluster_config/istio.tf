
resource "kubernetes_namespace" "istio_system" {
  metadata {
    annotations = {
      name = "istio-system"
    }
    name = "istio-system"
  }
}

resource "kubernetes_namespace" "istio_ingress" {
  metadata {
    annotations = {
      name = "istio-ingress"
    }
    name = "istio-ingress"
  }
}

resource "helm_release" "istio_base" {
  name       = "istio-base"
  namespace  = kubernetes_namespace.istio_system.metadata[0].name
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"

  set {
    name    = "defaultRevision"
    value   =  "default"
  }

  depends_on = [ kubernetes_namespace.istio_system ]
}

resource "helm_release" "istiod" {
  name       = "istiod"
  namespace  = kubernetes_namespace.istio_system.metadata[0].name
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"

  set {
    name    = "defaultRevision"
    value   =  "default"
  }

  depends_on = [ kubernetes_namespace.istio_system, helm_release.istio_base ]
}

resource "helm_release" "istio_ingress" {
  name       = "istio-ingress"
  namespace  = kubernetes_namespace.istio_ingress.metadata[0].name
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"

  depends_on = [ kubernetes_namespace.istio_ingress, helm_release.istio_base, helm_release.istiod ]
}