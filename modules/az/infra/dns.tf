data "azurerm_dns_zone" "haacs_dns" {
  name = var.k8s_ingress_domain
}

resource "azurerm_dns_a_record" "haacs_dns_root" {
  name                = "@"
  zone_name           = data.azurerm_dns_zone.haacs_dns.name
  resource_group_name = data.azurerm_dns_zone.haacs_dns.resource_group_name
  ttl                 = 1800
  target_resource_id  = azurerm_public_ip.ingress_ip.id
}

resource "azurerm_dns_cname_record" "haacs_dns_asterisk" {
  name                = "*"
  zone_name           = data.azurerm_dns_zone.haacs_dns.name
  resource_group_name = data.azurerm_dns_zone.haacs_dns.resource_group_name
  ttl                 = 1800
  record              = data.azurerm_dns_zone.haacs_dns.name
  depends_on = [
    azurerm_dns_a_record.haacs_dns_root
  ]
}
