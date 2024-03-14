#!/bin/bash

RESOURCE_GROUP_NAME="${{ env.RESOURCE_GROUP_NAME}}${{ env.ENVIRONMENT_NAME }}"
STORAGE_ACCOUNT_NAME="${{ env.STORAGE_ACCOUNT_NAME }}${{ env.ENVIRONMENT_NAME }}$RANDOM"
CONTAINER_NAME="${{ env.TERRAFORM_STATE_BLOB_CONTAINER_NAME }}${{ env.ENVIRONMENT_NAME }}"

echo {{ var.REGION }}
echo {{ var.ENVIRONMENT_NAME }}
echo {{ var.RESOURCE_GROUP_NAME }}
echo {{ var.STORAGE_ACCOUNT_NAME }}
echo {{ var.TERRAFORM_STATE_BLOB_CONTAINER_NAME }}
echo {{ var.STORAGE_ACCOUNT_SKU }}

# Create resource group
#az group create --name $RESOURCE_GROUP_NAME --location {{ env.REGION }}

# Create storage account
#az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku {{ env.STORAGE_ACCOUNT_SKU }} --encryption-services blob

# Create blob container
#az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
