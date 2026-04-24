include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/gcp/workload-identity-pool?ref=${values.ref}"
}

generate "import" {
  disable   = values.import_existing ? false : true
  path      = "import.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
import {
  to = google_iam_workload_identity_pool.pool
  id = "projects/$${var.project_id}/locations/global/workloadIdentityPools/$${var.workload_identity_pool_id}"
}
EOF
}

inputs = {
  project_id                = values.project_id
  workload_identity_pool_id = values.workload_identity_pool_id
  display_name              = values.display_name

  description = try(values.description, null)
  disabled    = try(values.disabled, false)
}
