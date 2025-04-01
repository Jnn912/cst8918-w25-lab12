# Terraform block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}

# Provider block
provider "azurerm" {
  features {}
}

# Resource group
resource "azurerm_resource_group" "githubactions_rg" {
  name     = "jin00098-githubactions-rg"
  location = "East US"
}

# Storage account
resource "azurerm_storage_account" "githubactions_sa" {
  name                     = "jin00098githubactions"
  resource_group_name      = azurerm_resource_group.githubactions_rg.name
  location                 = azurerm_resource_group.githubactions_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

# Storage container
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.githubactions_sa.name
  container_access_type = "private"
}

# Outputs
output "resource_group_name" {
  value = azurerm_resource_group.githubactions_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.githubactions_sa.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "arm_access_key" {
  value     = azurerm_storage_account.githubactions_sa.primary_access_key
  sensitive = true
}