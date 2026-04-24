resource "google_project_iam_custom_role" "role" {
  project     = var.project_id
  role_id     = var.role_id
  title       = var.title
  description = var.description
  permissions = var.permissions
}
