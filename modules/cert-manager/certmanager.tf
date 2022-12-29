resource "helm_release" "cert_manager" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.10.1"

  name      = "cert-manager"
  namespace = "kube-system"
  wait      = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "cluster-issuer" {
  name       = "cluster-issuer"
  chart      = "${path.module}/letsencrypt-issuer"
  namespace  = "kube-system"
  depends_on = [
    helm_release.cert_manager,
  ]
  set {
    name  = "letsencrypt_email"
    value = var.letsencrypt_email
  }
}
