# Deploy AKS using Terraform
This repo contains all necessary code to stand up an AKS cluster using Terraform.  A remote backend is configured using Azure CLI.  This repo also follows [Microsoft's Cloud Adoption Framework Naming Convention](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).

## Steps

1. Make sure a service principal is configured and has appropriate permissions for your Azure environment. This repo uses OpenID Connect (OIDC), but that is not a requirement.
2. Initialize Terraform State storage in Azure Storage Account using Azure CLI bash script and workflow.
3. Run "terraform plan" workflow to plan your Terraform provisioned AKS cluster.
4. If everything in Step 3 looks good, run "terraform apply" workflow to stand up an AKS cluster.
5. If the AKS cluster is no longer needed, run "terraform destroy" workflow.
