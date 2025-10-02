variable "name" {
  description = "The name of the policy."
  type        = string
}

variable "policy" {
  description = "The policy of the policy."
  type        = string
}

// Optional Variables

variable "path" {
  description = "The path of the policy."
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the policy."
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags of the policy."
  type        = map(string)
  default     = {}
}
