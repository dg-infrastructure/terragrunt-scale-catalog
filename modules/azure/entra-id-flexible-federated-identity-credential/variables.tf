variable "application_id" {
  type        = string
  description = "The Object ID of the Azure AD application."
}

variable "display_name" {
  type        = string
  description = "The display name for the new federated identity credential."
}

variable "issuer" {
  type        = string
  description = "The issuer URL of the external identity provider."
}

variable "audiences" {
  type        = list(string)
  description = "The audiences that can appear in the external token."
}

variable "claims_matching_expression_value" {
  type        = string
  description = "The expression to use when comparing the claims in the token"
}
