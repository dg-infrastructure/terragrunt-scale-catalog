variable "project_id" {
  description = "The GCP project ID where the workload identity pool will be created."
  type        = string
}

variable "workload_identity_pool_id" {
  description = "The ID of the workload identity pool. Must be 4-32 characters, and may contain lowercase letters, digits, and hyphens."
  type        = string
}

variable "display_name" {
  description = "A display name for the workload identity pool."
  type        = string
}

// Optional Variables

variable "description" {
  description = "A description of the workload identity pool."
  type        = string
  default     = null
}

variable "disabled" {
  description = "Whether the pool is disabled."
  type        = bool
  default     = false
}
