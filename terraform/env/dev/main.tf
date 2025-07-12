provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
}

module "container_app" {
  source              = "../../modules/container_app"
  prefix              = var.prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.network.private_subnet_ids["private-subnet-1"]
  container_image     = var.container_image
  container_port      = var.container_port
}

