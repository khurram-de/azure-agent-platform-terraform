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
  resource_group_name = "rg-${var.project_name}-${var.environment}"
  log_analytics_name  = "log-${var.project_name}-${var.environment}"
  container_env_name  = "cae-${var.project_name}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      environment = var.environment
      project    = var.project_name
      managed_by = "terraform"
    }
  )
}

resource "azurerm_resource_group" "platform" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_log_analytics_workspace" "platform" {
  name                = local.log_analytics_name
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name

  sku               = "PerGB2018"
  retention_in_days = var.log_retention_days
  daily_quota_gb    = var.log_daily_quota_gb

  tags = local.common_tags
}


resource "azurerm_container_app_environment" "platform" {
  name                       = local.container_env_name
  location                   = azurerm_resource_group.platform.location
  resource_group_name        = azurerm_resource_group.platform.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.platform.id

  tags = local.common_tags
}