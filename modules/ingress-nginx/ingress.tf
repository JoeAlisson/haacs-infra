resource "helm_release" "ingress_nginx" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.4.2"

  name             = "ingress-nginx"
  namespace        = "default"
  create_namespace = true
  wait             = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
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

  set {
    name  = "controller.service.externalIPs"
    value = var.externalIps
  }

  set {
    name  = "controler.extraArgs.default-ssl-certificate"
    value = var.default_ssl_certificate
  }
}

resource "helm_release" "ingress_default_certificate" {
  name  = "ingress-default-cert"
  chart = "${path.module}/certificate"
  namespace = var.default_ssl_certificate_namespace

  count = var.default_ssl_certificate == "" ? 0 : 1

  set {
    name = "secret.name"
    value = var.default_ssl_certificate
  }

  set {
    name = "secret.cert"
    value = var.default_ssl_certificate_cert_b64
  }

  set {
    name = "secret.key"
    value = var.default_ssl_certificate_key_b64
  }
}
