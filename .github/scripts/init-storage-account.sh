#!/bin/bash

RESOURCE_GROUP_FULL_NAME="$RESOURCE_GROUP_NAME-$ENVIRONMENT_NAME"
STORAGE_ACCOUNT_FULL_NAME="$STORAGE_ACCOUNT_NAME$ENVIRONMENT_NAME$RANDOM"
CONTAINER_NAME="$TERRAFORM_STATE_BLOB_CONTAINER_NAME-$ENVIRONMENT_NAME"

echo "$REGION"
echo "$ENVIRONMENT_NAME"
echo "$RESOURCE_GROUP_NAME"
echo "$STORAGE_ACCOUNT_NAME"
echo "$TERRAFORM_STATE_BLOB_CONTAINER_NAME"
echo "$STORAGE_ACCOUNT_SKU"

echo "$RESOURCE_GROUP_FULL_NAME"
echo "$STORAGE_ACCOUNT_FULL_NAME"
echo "$CONTAINER_NAME"

# Create resource group
az group create --name $RESOURCE_GROUP_FULL_NAME --location {{ secret.REGION }}

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_FULL_NAME --name $STORAGE_ACCOUNT_FULL_NAME --sku $STORAGE_ACCOUNT_SKU --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
