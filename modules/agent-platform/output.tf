output "resource_group_name" {
  description = "name of the platform resource group"
  value       = azurerm_resource_group.platform.name
}

output "resource_group_id" {
  description = "ID of the platform resource group"
  value       = azurerm_resource_group.platform.id
}

output "location" {
  description = "Location of the platform resource group"
  value       = azurerm_resource_group.platform.location
}

output "log_analytics_workspace_id" {
  description = "ID of the log analytics workspace(for container apps)"
  value       = azurerm_log_analytics_workspace.platform.id
}

output "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace"
  value       = azurerm_log_analytics_workspace.platform.name
}

output "container_apps_environtment_id" {
  description = "ID of the Container Apps environment (agents will run here)"
  value       = azurerm_container_app_environment.platform.id
}

output "container_apps_environtment_name" {
  description = "Name fo the container apps enviroment"
  value       = azurerm_container_app_environment.platform.name
}

output "tags" {
  description = "common tags applied to all resources"
  value       = local.common_tags
}