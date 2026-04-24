variable "project_id" {
  description = "The GCP project ID to grant IAM permissions on."
  type        = string
}

variable "member" {
  description = "The IAM member to grant roles to (e.g., serviceAccount:my-sa@my-project.iam.gserviceaccount.com)."
  type        = string
}

variable "roles" {
  description = "The list of IAM roles to grant to the member."
  type        = list(string)
}
