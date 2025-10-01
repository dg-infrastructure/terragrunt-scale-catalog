variable "name" {
  description = "The name of the role."
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider."
  type        = string
}

variable "sub_key" {
  description = "The key for the sub condition."
  type        = string
}

variable "sub_value" {
  description = "The value for the sub condition."
  type        = string
}

variable "aud_key" {
  description = "The key for the aud condition."
  type        = string
}

// Optional Variables

variable "path" {
  description = "The path of the role."
  type        = string
  default     = "/"
}

variable "aud_value" {
  description = "The value for the aud condition."
  type        = string
  default     = "sts.amazonaws.com"
}

variable "condition_operator" {
  description = "The operator for the condition to compare claims (use StringEquals for applies and StringLike for plans)."
  type        = string
  default     = "StringEquals"
}

variable "max_session_duration" {
  description = "The max session duration in seconds for the role."
  type        = number
  default     = 12 * 60 * 60
}

variable "permissions_boundary" {
  description = "The permissions boundary of the role."
  type        = string
  default     = null
}

variable "tags" {
  description = "The tags to apply to the role."
  type        = map(string)
  default     = {}
}
