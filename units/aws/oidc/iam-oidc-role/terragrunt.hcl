include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/aws/iam-oidc-role?ref=${values.ref}"
}

dependency "iam_openid_connect_provider" {
  config_path = values.iam_openid_connect_provider_config_path

  mock_outputs = {
    arn = "arn:aws:iam::123456789012:oidc-provider/mock-oidc-provider"
  }
}

inputs = {
  name = values.name

  oidc_provider_arn = dependency.iam_openid_connect_provider.outputs.arn

  condition_operator = try(values.condition_operator, "StringEquals")

  sub_key   = values.sub_key
  sub_value = values.sub_value

  max_session_duration = try(values.max_session_duration, 12 * 60 * 60)
  permissions_boundary = try(values.permissions_boundary, null)
  tags                 = try(values.tags, {})
}
