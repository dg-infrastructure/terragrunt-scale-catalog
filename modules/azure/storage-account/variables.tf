variable "name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "account_tier" {
  type        = string
  description = "The performance tier of the storage account"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "The replication type of the storage account"
  default     = "GRS"
}

variable "versioning_enabled" {
  type        = bool
  description = "Whether to enable versioning on the storage account"
  default     = true
}
