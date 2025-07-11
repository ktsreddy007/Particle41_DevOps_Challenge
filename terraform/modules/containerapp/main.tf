resource "azurerm_container_app_environment" "this" {
  name                         = "${var.prefix}-env"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  infrastructure_subnet_id     = var.subnet_id
  internal_load_balancer_enabled = false

  tags = {
    environment = "dev"
  }
}

resource "azurerm_container_app" "this" {
  name                         = "${var.prefix}-app"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = var.resource_group_name
  location                     = var.location
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  template {
    container {
      name   = "app"
      image  = var.container_image
      cpu    = 0.5
      memory = "1.0Gi"

      ports {
        port     = var.container_port
        protocol = "TCP"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.container_port
    transport        = "auto"
  }

  tags = {
    environment = "dev"
  }
}