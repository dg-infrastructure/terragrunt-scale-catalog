variable "service_account_id" {
  description = "The fully-qualified ID of the service account to bind to (e.g., projects/my-project/serviceAccounts/my-sa@my-project.iam.gserviceaccount.com)."
  type        = string
}

variable "member" {
  description = "The IAM member to grant access to. For Workload Identity, use principalSet://iam.googleapis.com/projects/{project_number}/locations/global/workloadIdentityPools/{pool_id}/attribute.repository/{org}/{repo} or principal://iam.googleapis.com/projects/{project_number}/locations/global/workloadIdentityPools/{pool_id}/subject/{subject}"
  type        = string
}
