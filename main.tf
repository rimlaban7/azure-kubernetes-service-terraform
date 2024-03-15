terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.92.0"
    }
  }

  cloud {
    hostname = "app.terraform.io"
    organization = "github-azure-terraform"

    workspaces {
      project = "azure-functions-terraform"
      name = "azure-function-terraform"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "resource_group" {
  source   = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "storage_account" {
  source = "./modules/storage_account"

  resource_group_name = var.resource_group_name
  location = var.location
  storage_account_prefix = var.storage_account_prefix
  environment = var.environment
}