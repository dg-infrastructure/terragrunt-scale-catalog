include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/aws/iam-policy?ref=${values.ref}"
}

inputs = {
  name   = values.name
  policy = values.policy

  tags = try(values.tags, {})
}
