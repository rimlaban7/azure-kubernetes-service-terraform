variable "storage_account_prefix" {
    type = string
    sensitive = true
}

variable "resource_group_name" {
  type = string
  sensitive = true
}

variable "account_tier" {
    type = string
    sensitive = true
    default = "Standard"
}

variable "location" {
  type = string
  sensitive = true
}

variable "account_replication_type" {
    type = string
    sensitive = true
    default = "LRS"
}

variable "environment" {
    type = string
    sensitive = true
}