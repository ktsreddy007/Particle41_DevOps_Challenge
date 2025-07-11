output "resource_group_name" {
  value = module.resource_group.name
}

output "resource_group_location" {
  value = module.resource_group.location
}

output "resource_group_id" {
  value = module.resource_group.id
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "container_app_url" {
  value = module.container_app.container_app_url
}
