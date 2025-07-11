variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "container_image" {}
variable "container_port" {
  default = 80
}