variable "scope" {
  description = "The scope at which the role assignment applies."
  type        = string
}

variable "role_definition_name" {
  description = "The name of the role definition to assign to the service principal."
  type        = string
}

variable "principal_id" {
  description = "The object ID of the Entra ID service principal."
  type        = string
}

variable "description" {
  description = "The description for the role assignment."
  type        = string
}
