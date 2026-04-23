include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/gcp/custom-role?ref=${values.ref}"
}

inputs = {
  project_id  = values.project_id
  role_id     = values.role_id
  title       = values.title
  description = try(values.description, "")
  permissions = values.permissions
}
