terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.92.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-aks-prod"
    storage_account_name = "t"
    container_name       = "stakstfstateprod"
    key                  = "prod.teroidc.tfstate"
  }
}

provider "azurerm" {
  features {}
}

/*
locals {
    full_resource_group_name = format("%s-%s", var.resource_group_name, var.environment)
    full_storage_account_name = format("%s%s", var.storage_account_name, var.environment)
}

module "resource_group" {
  source   = "./modules/resource_group"
  resource_group_name = local.full_resource_group_name
  location = var.location
}

module "storage_account" {
  source = "./modules/storage_account"

  resource_group_name = var.resource_group_name
  location = var.location
  storage_account_name = local.full_storage_account_name
  environment = var.environment
  account_replication_type = var.account_replication_type
  account_tier = var.account_tier
}
*/