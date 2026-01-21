output "id" {
  description = "The resource ID of the service account."
  value       = google_service_account.service_account.id
}

output "name" {
  description = "The fully-qualified name of the service account."
  value       = google_service_account.service_account.name
}

output "email" {
  description = "The email address of the service account."
  value       = google_service_account.service_account.email
}

output "unique_id" {
  description = "The unique ID of the service account."
  value       = google_service_account.service_account.unique_id
}

output "member" {
  description = "The IAM member string for the service account (serviceAccount:email)."
  value       = "serviceAccount:${google_service_account.service_account.email}"
}
