include "root" {
  path = find_in_parent_folders("root.hcl")
}

exclude {
  if      = try(values.exclude_if, false)
  actions = ["all"]
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
