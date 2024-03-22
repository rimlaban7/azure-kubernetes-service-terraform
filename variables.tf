variable "storage_account_import_id" {
  type = string
  sensitive = true
}

variable "resource_group_import_id" {
  type = string
  sensitive = true
}

variable "environment" {
  type = string
  sensitive = true
}

variable "resource_group_name" {
    type = string
    sensitive = true
}

variable "location" {
  type = string
  sensitive = true
}

variable "storage_account_name" {
    type = string
    sensitive = true
}

variable "account_tier" {
    type = string
    sensitive = true
}

variable "account_replication_type" {
    type = string
    sensitive = true
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

