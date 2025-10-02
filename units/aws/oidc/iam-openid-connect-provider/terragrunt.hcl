include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/aws/iam-openid-connect-provider?ref=${values.ref}"
}

inputs = {
  url            = values.url
  client_id_list = values.client_id_list

  tags = try(values.tags, {})
}
