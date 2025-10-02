include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.base_url}//modules/azure/resource-group?ref=${values.ref}"
}

inputs = {
  name     = values.name
  location = values.location
}
