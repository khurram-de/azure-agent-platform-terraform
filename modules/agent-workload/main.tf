terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

locals {
  identity_name      = "id-${var.agent_name}"
  key_vault_name     = "kv-${var.agent_name}-${random_string.kv_suffix.result}"
  container_app_name = "ca-${var.agent_name}"
}

resource "random_string" "kv_suffix" {
  length  = 6
  special = false
  upper   = false
}


resource "azurerm_user_assigned_identity" "agent" {
  name                = local.identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_key_vault" "agent" {
  name                = local.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled = true

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  tags = var.tags
}

data "azurerm_client_config" "current" {}


resource "azurerm_role_assignment" "agent_vault_secrets_user" {
  scope                = azurerm_key_vault.agent.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.agent.principal_id
}


resource "azurerm_container_app" "agent" {
  name                         = local.container_app_name
  container_app_environment_id = var.container_apps_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.agent.id]
  }

  template {
    min_replicas  = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = var.agent_name
      image  = var.container_image
      cpu    = var.cpu
      memory = var.memory

      env {
        name  = "AZURE_CLIENT_ID"
        value = azurerm_key_vault.agent.name
      }

      env {
        name  = "KEY_VAULT_NAME"
        value = azurerm_key_vault.agent.name
      }
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_enabled ? [1] : []

    content {
      external_enabled = true
      target_port      = var.ingress_target_port
      traffic_weight {
        percentage      = 100
        latest_revision = true
      }
    }
  }

  tags = var.tags
}