resource "azurerm_container_app_environment" "main" {
  name                       = "${var.prefix}-ca-env"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  infrastructure_subnet_id   = var.subnet_id
}

resource "azurerm_container_app" "main" {
  name                         = "${var.prefix}-container-app"
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = var.resource_group_name
  location                     = var.location
  revision_mode                = "Single"

  template {
    container {
      name   = "app"
      image  = var.container_image
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.container_port
    transport        = "auto"
  }
}