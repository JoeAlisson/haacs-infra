output "k8s_ingress_host" {
  value = module.k8s_infra.cluster_domain_root
}

output "k8s_ingress_ip" {
  value = module.k8s_infra.load_balancer_ip
}
