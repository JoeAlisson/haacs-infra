resource "helm_release" "ingress_nginx" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  version = "4.2.3"

  name  = "ingress-nginx"
  namespace = "ingress-nginx"
  create_namespace = true
  wait = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name = "controller.service.annotations.${var.provider_loadbalancer_id_annotation}"
    value = var.loadbalancer_id
  }
}
