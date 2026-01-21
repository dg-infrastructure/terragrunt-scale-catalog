include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/gcp/service-account?ref=${values.ref}"
}

inputs = {
  project_id   = values.project_id
  account_id   = values.account_id
  display_name = values.display_name

  description = try(values.description, null)
  disabled    = try(values.disabled, false)
}
