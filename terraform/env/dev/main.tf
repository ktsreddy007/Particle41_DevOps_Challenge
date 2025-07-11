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
  vnet_name           = "tejavnet"
  address_space       = ["10.0.0.0/16"]

   public_subnets = [
    { name = "public-subnet-1", address_prefix = "10.0.0.0/24" },
    { name = "public-subnet-2", address_prefix = "10.0.1.0/24" }
  ]

  private_subnets = [
    { name = "private-subnet-1", address_prefix = "10.0.2.0/23" },
    { name = "private-subnet-2", address_prefix = "10.0.4.0/24" }
  ]
}

module "container_app" {
  source              = "../../modules/container_app"
  prefix              = "teja"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id = module.network.private_subnet_ids["private-subnet-1"]
  container_image     = "ktsreddy/teja_particle41_devops-challenge:v1.0"
  container_port      = 5000
}

