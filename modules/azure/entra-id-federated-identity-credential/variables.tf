variable "application_id" {
  description = "The ID of the Entra ID application."
  type        = string
}

variable "display_name" {
  description = "The display name for the federated identity credential."
  type        = string
}

variable "description" {
  description = "The description for the federated identity credential."
  type        = string
}

variable "audiences" {
  description = "The audiences for the federated identity credential."
  type        = list(string)
}

variable "issuer" {
  description = "The issuer for the federated identity credential."
  type        = string
}

variable "subject" {
  description = "The subject for the federated identity credential."
  type        = string
}
