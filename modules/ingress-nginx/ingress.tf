resource "helm_release" "ingress_nginx" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.4.0"

  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  wait             = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.service.annotations.${var.provider_loadbalancer_annotation}"
    value = var.provider_loadbalancer_annotation_value
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.loadBalancer_ip
  }
}
