variable "project_id" {
  description = "The GCP project ID in which to create the custom role."
  type        = string
}

variable "role_id" {
  description = "The ID of the custom role. Must be unique within the project and match [a-zA-Z0-9_]{3,64}."
  type        = string
}

variable "title" {
  description = "A human-readable title for the custom role."
  type        = string
}

variable "description" {
  description = "A description of the custom role."
  type        = string
  default     = ""
}

variable "permissions" {
  description = "The list of IAM permissions to include in the custom role (e.g., storage.objects.get)."
  type        = list(string)
}
