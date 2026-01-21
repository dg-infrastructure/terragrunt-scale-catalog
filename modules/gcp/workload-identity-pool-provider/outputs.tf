output "id" {
  description = "The resource ID of the provider."
  value       = google_iam_workload_identity_pool_provider.provider.id
}

output "name" {
  description = "The resource name of the provider."
  value       = google_iam_workload_identity_pool_provider.provider.name
}

output "workload_identity_pool_provider_id" {
  description = "The provider ID."
  value       = google_iam_workload_identity_pool_provider.provider.workload_identity_pool_provider_id
}

output "state" {
  description = "The state of the provider."
  value       = google_iam_workload_identity_pool_provider.provider.state
}
