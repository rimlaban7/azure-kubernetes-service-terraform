variable "resource_group_name" {
    type = string
    sensitive = true
    default = "terra_cloud_github_actions_rg"
}

variable "location" {
  type = string
  sensitive = true
  default = "East Us 2"
}

variable "storage_account_prefix" {
    type = string
    sensitive = true
    default = "terracloudgithub"
}

variable "environment" {
  type = string
  sensitive = true
  default = "prod"
}

variable "storage_account_import_id" {
  type = string
  sensitive = true
}

variable "resource_group_import_id" {
  type = string
  sensitive = true
}