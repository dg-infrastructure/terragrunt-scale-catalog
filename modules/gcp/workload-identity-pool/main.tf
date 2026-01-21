resource "google_iam_workload_identity_pool" "pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.display_name
  description               = var.description
  disabled                  = var.disabled
}
