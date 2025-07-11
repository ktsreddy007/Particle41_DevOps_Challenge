output "private_subnet_ids" {
  value = [
    module.vnet.subnets["private-subnet-0"].id,
    module.vnet.subnets["private-subnet-1"].id
  ]
}

output "vnet_id" {
  value = module.vnet.vnet_id
}