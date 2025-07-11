provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "../../modules/network"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "container_app" {
  source              = "../../modules/container_app"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.private_subnet_ids[0]
  container_image     = var.container_image
  container_port      = var.container_port
}

output "container_app_url" {
  value = module.container_app.container_app_url
}