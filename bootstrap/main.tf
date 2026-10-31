terraform {
    required_version = ">= 1.0"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.0"
        }
        random = {
            source  = "hashicorp/random"
            version = "~> 3.0"
        }
    }
}

provider "azurerm" {
    features {
        resource_group {
            prevent_deletion_if_contains_resources = false
        }
        key_vault {
            purge_soft_delete_on_destroy = true
            recover_soft_deleted_key_vaults = true
        }
    }

    subscription_id = var.subscription_id
}

resource "random_string" suffix {
    length  = 6
    special = false
    upper   = false
}

resource "azurerm_resource_group" "tfstate" {
    name     = "rg-terraform-state-${var.environment}"
    location = var.location
    tags     = var.tags
}

resource "azurerm_storage_account" "tfstate" {
    name = "sttfstate${random_string.suffix.result}"
    resource_group_name = azurerm_resource_group.tfstate.name
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    min_tls_version = "TLS1_2"

    allow_nested_items_to_be_public = false

    blob_properties {
        versioning_enabled = true
    }

    tags = var.tags
}


resource "azurerm_storage_container" "tfstate" {
    name = "tfstate"
    storage_account_id    = azurerm_storage_account.tfstate.id
    container_access_type = "private"
}
