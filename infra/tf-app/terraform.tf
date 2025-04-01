# Terraform block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"

  # Backend block
  backend "azurerm" {
    resource_group_name  = "jin00098-githubactions-rg"
    storage_account_name = "jin00098githubactions"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
  }
}

# Provider block
provider "azurerm" {
  features {}
}