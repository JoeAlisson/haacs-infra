resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  version = "5.4.1"

  name  = "argocd"
  namespace = "argocd"
  create_namespace = true
  wait = true

  values = [
    file("${path.module}/manifests/argo-cm.yaml")
  ]

  set {
    name  = "server.config.url"
    value = "argocd.${var.ingress_domain}"
  }

  set {
      name  = "configs.secret.extra.oidc\\.keycloak\\.clientSecret"
      value = var.argocd_oauth_key
  }
}

resource "helm_release" "argocd_apps" {
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argocd-apps"
  version = "0.0.1"

  name  = "argo-apps"
  namespace = "argocd"
  depends_on = [helm_release.argocd]

  values = [
    file("${path.module}/manifests/applications.yaml")
  ]
}
