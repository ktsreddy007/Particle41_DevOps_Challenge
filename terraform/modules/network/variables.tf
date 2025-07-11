variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "public_subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "private_subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
}