locals {
  project_hcl = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  gcp_project_id    = local.project_hcl.locals.gcp_project_id
  gcp_region        = local.project_hcl.locals.gcp_region
  state_bucket_name = local.project_hcl.locals.state_bucket_name
}

# FIXME: Uncomment the code below when you've successfully bootstrapped Pipelines state.
#
# remote_state {
#   backend = "gcs"
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite"
#   }
#   config = {
#     bucket   = local.state_bucket_name
#     prefix   = "${path_relative_to_include()}/tofu.tfstate"
#     project  = local.gcp_project_id
#     location = local.gcp_region
#   }
# }

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project = "${local.gcp_project_id}"
  region  = "${local.gcp_region}"
}
EOF
}
