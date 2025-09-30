variable "name" {
  type        = string
  description = "The name of the storage container"
}

variable "storage_account_id" {
  type        = string
  description = "The ID of the storage account"
}

variable "container_access_type" {
  type        = string
  description = "The access type of the storage container"
  default     = "private"
}
