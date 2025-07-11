output "container_app_url" {
  value = azurerm_container_app.this.latest_revision_fqdn
}