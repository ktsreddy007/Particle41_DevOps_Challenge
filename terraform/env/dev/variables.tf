variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "prefix" {
  type = string
  description = "Prefix for naming resources"
}
variable "container_image" {
  type        = string
  description = "Container image for deployment"
}
variable "container_port" {
  type        = number
  description = "Port on which container listens"
}