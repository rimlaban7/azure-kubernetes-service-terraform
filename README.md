# TL;DR

## Project Goal
1. Demonstrate use of OIDC for Microsoft Entra and GitHub Actions authentication
2. Demonstrate use of Azure Storage Account as Terraform Backend for state storage
3. Demonstrate minimum viable product (MVP) Azure Kubernetes Service (AKS) deployment 

## Configuration
1. Configure OIDC
2. Configure Repository Secrets
3. Run `Initialize Remote Backend` that is defined within `init-remote-backend.yml`
4. Run `Deploy Infrastructure` that is defined within `deploy-infra.yml`

![image](/aks-terraform-oidc.svg)

# Deploy AKS using Terraform
This repo contains all necessary code to stand up an AKS cluster using Terraform.  A remote backend is configured using Azure CLI. 

## Overview

This post will demonstrate the deployment of an Azure Kubernetes Service using Terraform and GitHub Actions for CI/CD. For this project we'll also make sure GitHub and Azure use OpenID Connect (OIDC) for authenticating service principals. This will save us from storing client secrets (basically passwords).  For an overview of how this works, see my blog post titled [Authenticating GitHub and Azure DevOps using OpenID Connect ](https://www.theroadtocloud.com/blog/github-and-azure-devops-oidc-authentication/).

## Prerequisites

Before you begin, you'll need to have the following:

- An Azure subscription
- A GitHub account
- Your favorite IDE - I prefer Visual Studio Code with the below extensions installed
    - GitHub Actions
    - HashiCorp HCL 
    - HashiCorp Terraform

## Configuration

### OpenID Connect (OIDC)

We'll need to create an Entra application and service principal that has the appropriate permissions to create and modify Azure resources.  There are a few different ways to accomplish this depending on you subscription type and preferred method (Azure Portal, Azure CLI, or PowerShell).  For this project, I followed this guide: [Configuring OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure).  For this to work correctly, you'll need to have the below values configured.

| Configuration Item | Value                                   |
| ------------------ | --------------------------------------- |
| Organization       | *GitHub User Name or Organization Name* |
| Repository         | *Repository Name*                       |
| Entity Type        | `Environment`                           |
| Based on selection | *Environment Name*                      |


### GitHub Repository Secrets

The GitHub Actions and Terraform code we will use for this project require an environment as well as repository secrets to be configured. For step-by-step instructions on how to create an environment, see [Creating an Environment](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#creating-an-environment). For this project we'll use a Trunk-Based branching strategy. This is a good branching strategy for individual work or small teams.  For more inforomation, see [Branching Strategies](https://www.theroadtocloud.com/blog/branching-strategies/). Map this environment to a branch.  For Trunk-Based branching strategy, this is usually `main`. We'll need to call this environment the same as in the above OIDC configuration. Finally, add the below repository secrets.

| Secret | Value |
|-|-|
| AZURE_TENANT_ID | Entra Tenant ID |
| AZURE_SUBSCRIPTION_ID | Subscription ID for Azure |
| AZURE_CLIENT_ID | App Registration / Client ID for OIDC Service Principal |
| ACCOUNT_REPLICATION_TYPE | [Storage Account Config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) |
| ACCOUNT_TIER | [Storage Account Config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) |
| LOCATION | [Storage Account Config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) |
| STORAGE_ACCOUNT_NAME | [Storage Account Config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account). This will be suffixed with environment name. |
| BLOB_CONTAINER_NAME | [Storage Account Config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account). This will be suffixed with environment name. |
| RESOURCE_GROUP_NAME | Resource Group Name.  Will be prefixed with "rg" and suffixed with environment name. |

Once OIDC is configured in Entra and Azure, and these repository secrets above are added to GitHub environment secrets, you can run `test-oidc.yml` to validate whether or not your GitHub Actions Workflow can connect to Azure.


### Initialize Terraform Remote State Storage

When you execute `terraform init`, you're setting up the providers and linking to any existing state of the infrastructure. For this project, the backend state is kept in an Azure storage account.  You only need to run the GitHub Action Workflow `Initialize Remote Backend` once, and it will initialize an Azure storage account for Terraform remote state. Details for this workflow can be seen in `init-remote-backedn.yml`. As you can see, this uses Azure CLI commands. Make sure to provide the proper environment name, default is `prod`, which is mapped to the `main` branch. In the next step, we'll import infrastructure initialized with this script into Terraform state, so Terraform can also track it.  It makes much more sense to use declerative syntax with Terraform for further provisioning, instead of Azure CLI's procedural syntax.  This will make modifying infrastructure and management much easier and simpler.

## Import Resources and Deploy Infrastructure

The step above initialized a resource group and storage account.  Let's go ahead and import these two resources into Terraform.  First, go ahead and grab the Resource IDs for both of these and configure them in two additional repository secrets listed below.  You can grab resource ID values for these with `az group list` and `az storage account list`.

| Secret | Value |
|-|-|
| RESOURCE_GROUP_IMPORT_ID | `Resource Group Resource ID` |
| STORAGE_ACCOUNT_IMPORT_ID | `Storage Account Resource ID` |

Next, run the GitHub Action Workflow `Deploy Infrastructure` that is defined within `deploy-infra.yml`.  This will import the two resources above as well as deploy the rest of the infrastructure.

