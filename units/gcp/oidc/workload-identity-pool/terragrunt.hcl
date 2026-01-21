include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/gcp/workload-identity-pool?ref=${values.ref}"
}

inputs = {
  project_id                = values.project_id
  workload_identity_pool_id = values.workload_identity_pool_id
  display_name              = values.display_name

  description = try(values.description, null)
  disabled    = try(values.disabled, false)
}
