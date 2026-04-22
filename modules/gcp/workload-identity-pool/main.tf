import {
  for_each = var.import_existing ? toset(["pool"]) : toset([])
  to       = google_iam_workload_identity_pool.pool
  id       = "projects/${var.project_id}/locations/global/workloadIdentityPools/${var.workload_identity_pool_id}"
}

resource "google_iam_workload_identity_pool" "pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.display_name
  description               = var.description
  disabled                  = var.disabled
}
