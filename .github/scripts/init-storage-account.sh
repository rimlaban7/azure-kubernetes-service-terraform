#!/bin/bash

RESOURCE_GROUP_NAME="${{ env.RESOURCE_GROUP_NAME}}${{ env.ENVIRONMENT_NAME }}"
STORAGE_ACCOUNT_NAME="${{ env.STORAGE_ACCOUNT_NAME }}${{ env.ENVIRONMENT_NAME }}$RANDOM"
CONTAINER_NAME="${{ env.TERRAFORM_STATE }}${{ env.ENVIRONMENT_NAME }}"

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location {{ env.REGION }}

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku {{ env.STORAGE_ACCOUNT_SKU }} --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
