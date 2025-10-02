include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/aws/iam-role-policy-attachment?ref=${values.ref}"
}

dependency "iam_role" {
  config_path = values.iam_role_config_path

  mock_outputs = {
    name = "mock-role"
  }
}

dependency "iam_policy" {
  config_path = values.iam_policy_config_path

  mock_outputs = {
    arn = "arn:aws:iam::123456789012:policy/mock-policy"
  }
}

inputs = {
  role_name  = dependency.iam_role.outputs.name
  policy_arn = dependency.iam_policy.outputs.arn

  tags = try(values.tags, {})
}
