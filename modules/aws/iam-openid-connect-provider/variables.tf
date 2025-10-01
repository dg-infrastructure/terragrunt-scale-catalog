variable "url" {
  description = "The URL of the identity provider."
  type        = string
}

variable "client_id_list" {
  description = "The list of client IDs."
  type        = list(string)
}

// Optional Variables

variable "tags" {
  description = "The tags to apply to the identity provider."
  type        = map(string)
  default     = {}
}
