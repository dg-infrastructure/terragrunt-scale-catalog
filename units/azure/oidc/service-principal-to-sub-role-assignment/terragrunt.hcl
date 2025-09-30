include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.url}//modules/azure/entra-id-role-assignment-to-sub?ref=${values.ref}"
}

dependency "service_principal" {
  config_path = values.service_principal_config_path

  mock_outputs = {
    object_id    = "/applications/12345678-1234-1234-1234-123456789012"
    display_name = "mock-display-name"
  }
}

inputs = {
  principal_id = dependency.service_principal.outputs.object_id

  role_definition_name = values.role_definition_name
  description          = values.description
}
