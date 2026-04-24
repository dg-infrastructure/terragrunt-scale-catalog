output "id" {
  description = "The resource ID of the workload identity pool."
  value       = google_iam_workload_identity_pool.pool.id
}

output "name" {
  description = "The resource name of the workload identity pool."
  value       = google_iam_workload_identity_pool.pool.name
}

output "workload_identity_pool_id" {
  description = "The workload identity pool ID."
  value       = google_iam_workload_identity_pool.pool.workload_identity_pool_id
}

output "state" {
  description = "The state of the workload identity pool."
  value       = google_iam_workload_identity_pool.pool.state
}
