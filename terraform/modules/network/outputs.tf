output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "private_subnet_ids" {
  value = {
    for name, subnet in azurerm_subnet.private :
    name => subnet.id
  }
}

output "public_subnet_ids" {
  value = [for subnet in azurerm_subnet.public : subnet.id]
}