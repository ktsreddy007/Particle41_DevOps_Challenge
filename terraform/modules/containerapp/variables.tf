variable "prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type        = string
  description = "Private subnet for VNet integration"
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}