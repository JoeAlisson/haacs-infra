output "k8s_ingress_ip" {
  value = module.kubernetes.load_balancer_ip
}
