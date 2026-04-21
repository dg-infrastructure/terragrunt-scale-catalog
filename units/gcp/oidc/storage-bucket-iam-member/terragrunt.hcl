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

inputs = {
  bucket = values.bucket
  member = dependency.service_account.outputs.member
  roles  = values.roles
}
