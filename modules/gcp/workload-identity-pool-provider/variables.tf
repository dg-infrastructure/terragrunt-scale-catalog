variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "workload_identity_pool_id" {
  description = "The ID of the workload identity pool to add the provider to."
  type        = string
}

variable "workload_identity_pool_provider_id" {
  description = "The ID of the workload identity pool provider. Must be 4-32 characters, and may contain lowercase letters, digits, and hyphens."
  type        = string
}

variable "display_name" {
  description = "A display name for the provider."
  type        = string
}

variable "issuer_uri" {
  description = "The OIDC issuer URI. For GitHub Actions, this is https://token.actions.githubusercontent.com"
  type        = string
}

variable "attribute_mapping" {
  description = "Maps claims from the external identity to Google Cloud attributes."
  type        = map(string)
}

// Optional Variables

variable "description" {
  description = "A description of the provider."
  type        = string
  default     = null
}

variable "disabled" {
  description = "Whether the provider is disabled."
  type        = bool
  default     = false
}

variable "attribute_condition" {
  description = "A CEL expression that must evaluate to true for a credential exchange to succeed. Use this to restrict which identities can authenticate."
  type        = string
  default     = null
}
