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
  value       = module.platform.resource_group_name
}

output "container_apps_environment_id" {
  description = "Container Apps environment ID"
  value       = module.platform.container_apps_environtment_id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = module.platform.log_analytics_workspace_id
}

output "agent_urls" {
  description = "HTTPS URLS for each agent"
  value = {
    for name, agent in module.agents : name => agent.container_app_url
  }
}

output "agent_key_vaults" {
  description = "Key Vault names for each agent"
  value = {
    for name, agent in module.agents : name => agent.key_vault_name
  }
}