variable "project_id" {
  description = "The GCP project ID where the service account will be created."
  type        = string
}

variable "account_id" {
  description = "The account ID of the service account. Must be 6-30 characters, and may contain lowercase letters, digits, and hyphens."
  type        = string
}

variable "display_name" {
  description = "A display name for the service account."
  type        = string
}

// Optional Variables

variable "description" {
  description = "A description of the service account."
  type        = string
  default     = null
}

variable "disabled" {
  description = "Whether the service account is disabled."
  type        = bool
  default     = false
}
