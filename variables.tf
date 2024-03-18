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

variable "storage_account_import_id" {
  type = string
  sensitive = true
}

variable "resource_group_import_id" {
  type = string
  sensitive = true
}