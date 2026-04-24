variable "bucket" {
  description = "The name of the GCS bucket to grant IAM permissions on."
  type        = string
}

variable "member" {
  description = "The IAM member to grant roles to (e.g., serviceAccount:my-sa@my-project.iam.gserviceaccount.com)."
  type        = string
}

variable "roles" {
  description = "The list of IAM roles to grant to the member on the bucket."
  type        = list(string)
}
