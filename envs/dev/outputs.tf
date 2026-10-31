output "environment" {
    description = "Current environment"
    value       = var.environment
}

output "location" {
    description = "Deployment location"
    value       = var.location
}

output "resource_group_name" {
    description = "Platform resource group name."
    value = module.platform.resource_group_name
}

output "container_apps_environment_id" {
    description = "Container Apps environment ID"
    value = module.platform.container_apps_environtment_id
}

output "log_analytics_workspace_id" {
    description = "Log analytics woorkspace ID"
    value = module.platform.log_analytics_workspace_id
}