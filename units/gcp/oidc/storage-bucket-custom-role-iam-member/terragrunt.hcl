include "root" {
  path = find_in_parent_folders("root.hcl")
}

exclude {
  if      = try(values.exclude_if, false)
  actions = ["all"]
}

terraform {
  source = "${values.base_url}//modules/gcp/storage-bucket-iam-member?ref=${values.ref}"
}

dependency "service_account" {
  config_path = values.service_account_config_path

  mock_outputs = {
    member = "serviceAccount:mock-sa@mock-project.iam.gserviceaccount.com"
  }
}

dependency "custom_role" {
  config_path = values.custom_role_config_path

  mock_outputs = {
    role_name = "projects/mock-project/roles/mockRole"
  }
}

inputs = {
  bucket = values.bucket
  member = dependency.service_account.outputs.member
  roles  = [dependency.custom_role.outputs.role_name]
}
