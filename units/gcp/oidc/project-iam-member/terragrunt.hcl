include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/gcp/project-iam-member?ref=${values.ref}"
}

dependency "service_account" {
  config_path = values.service_account_config_path

  mock_outputs = {
    member = "serviceAccount:mock-sa@mock-project.iam.gserviceaccount.com"
  }
}

inputs = {
  project_id = values.project_id
  member     = dependency.service_account.outputs.member
  roles      = values.roles
}
