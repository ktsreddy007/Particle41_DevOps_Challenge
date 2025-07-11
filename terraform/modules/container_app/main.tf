resource "azurerm_container_app_environment" "this" {
  name                         = "${var.prefix}-aca-env"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  infrastructure_subnet_id = var.subnet_id
  internal_load_balancer_enabled = false
  zone_redundancy_enabled         = false

  tags = {
    environment = "dev"
  }
}

resource "azurerm_container_app" "this" {
  name                         = "${var.prefix}-aca"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  ingress {
    external_enabled = true
    target_port      = var.container_port
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = "app"
      image  = var.container_image
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  tags = {
    environment = "dev"
  }
}