# Deploy AKS using Terraform
This repo contains all necessary code to stand up an AKS cluster using Terraform.  A remote backend is configured using Azure CLI.  This repo also follows [Microsoft's Cloud Adoption Framework Naming Convention](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).

## Steps

1. Make sure a service principal is configured and has appropriate permissions for your Azure environment. This repo uses OpenID Connect (OIDC) to avoid storing and managing client secrets (passwords).
- Make sure the following repository secrets are configured:
    - AZURE_TENANT_ID
    - AZURE_SUBSCRIPTION_ID
    - AZURE_CLIENT_ID
2. Initialize Terraform remote state storage in Azure Storage Account using `init-remote-backend.yml` workflow. This Storage Account will be used as a remote backend to store Terraform state, but will initially be empty.
- Make sure the following repository secrets are configured:
    - REGION
    - ENVIRONMENT_NAME
    - RESOURCE_GROUP_NAME
    - STORAGE_ACCOUNT_NAME
    - BLOB_CONTAINER_NAME
    - STORAGE_ACCOUNT_SKU
3. Run "terraform plan" workflow to plan your Terraform provisioned AKS cluster.
4. If everything in Step 3 looks good, run "terraform apply" workflow to stand up an AKS cluster.
5. If the AKS cluster is no longer needed, run "terraform destroy" workflow.
