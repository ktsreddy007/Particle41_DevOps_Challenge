module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]

  subnet_prefixes = [
    "10.0.0.0/24",
    "10.0.0.16/24",
    "10.0.1.0/24",
    "10.0.1.16/24"
  ]

  subnet_names = [
    "public-subnet-0",
    "public-subnet-1",
    "private-subnet-0",
    "private-subnet-1"
  ]

  subnet_delegation = {
    "private-subnet-0" = [
      {
        name = "delegation"
        service_delegation = {
          name = "Microsoft.App/managedEnvironments"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    ]
  }
}