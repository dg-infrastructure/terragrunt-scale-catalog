include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${values.url}//modules/azure/entra-id-application?ref=${values.ref}"
}

inputs = {
  display_name = values.display_name
  description  = values.description
}
