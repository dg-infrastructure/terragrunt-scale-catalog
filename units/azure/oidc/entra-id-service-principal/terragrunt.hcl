include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/azure/entra-id-service-principal?ref=${values.ref}"
}

dependency "app" {
  config_path = values.app_config_path

  mock_outputs = {
    client_id = "12345678-1234-1234-1234-123456789012"
  }
}

inputs = {
  client_id = dependency.app.outputs.client_id
}
