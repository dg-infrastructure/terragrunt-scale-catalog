output "role_name" {
  description = "The fully qualified name of the custom role (e.g., projects/PROJECT_ID/roles/ROLE_ID)."
  value       = google_project_iam_custom_role.role.name
}

output "role_id" {
  description = "The role ID of the custom role."
  value       = google_project_iam_custom_role.role.role_id
}
