variable "name" {
  description = "The name of the custom role definition. This must be unique within the scope."
  type        = string
}

variable "scope" {
  description = "The scope at which the custom role definition is created (e.g., subscription ID, resource group ID). If not provided, defaults to the current subscription."
  type        = string
  default     = null
}

variable "description" {
  description = "A description of the custom role definition."
  type        = string
  default     = ""
}

variable "actions" {
  description = "List of allowed actions for the custom role."
  type        = list(string)
  default     = []
}

variable "not_actions" {
  description = "List of denied actions for the custom role."
  type        = list(string)
  default     = []
}

variable "data_actions" {
  description = "List of allowed data actions for the custom role."
  type        = list(string)
  default     = []
}

variable "not_data_actions" {
  description = "List of denied data actions for the custom role."
  type        = list(string)
  default     = []
}

variable "assignable_scopes" {
  description = "List of scopes where the custom role can be assigned. If not provided, defaults to the scope of the role definition."
  type        = list(string)
  default     = null
}

