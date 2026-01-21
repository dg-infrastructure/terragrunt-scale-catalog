include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/gcp/service-account-iam-binding?ref=${values.ref}"
}

dependency "service_account" {
  config_path = values.service_account_config_path

  mock_outputs = {
    name = "projects/mock-project/serviceAccounts/mock-sa@mock-project.iam.gserviceaccount.com"
  }
}

inputs = {
  service_account_id = dependency.service_account.outputs.name
  member             = values.member
}
