output "identity_id" {
  description = "ID of the managed identity"
  value       = azurerm_user_assigned_identity.agent.id
}

output "identity_client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.agent.client_id
}

output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.agent.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.agent.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.agent.vault_uri
}

output "container_app_id" {
  description = "ID of the Container App"
  value       = azurerm_container_app.agent.id
}

output "container_app_fqdn" {
  description = "Fully qualified domain name of the Container App"
  value       = var.ingress_enabled ? azurerm_container_app.agent.latest_revision_fqdn : null
}

output "container_app_url" {
  description = "HTTPS URL of the Container App"
  value       = var.ingress_enabled ? "https://${azurerm_container_app.agent.latest_revision_fqdn}" : null
}
