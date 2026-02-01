output "web_private_ip" {
  value = azurerm_network_interface.web_nic.private_ip_address
}

output "router_private_ip" {
  value = azurerm_network_interface.router_nic.private_ip_address
}
