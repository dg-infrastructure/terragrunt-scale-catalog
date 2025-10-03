locals {
  // Read from parent configurations instead of defining these values locally
  // so that other stacks and units in this directory can reuse the same configurations.
  account_hcl = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

stack "bootstrap" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//stacks/aws/github/pipelines-bootstrap?ref={{ .TerragruntScaleCatalogRef }}"
  path   = "bootstrap"

  values = {
    oidc_resource_prefix = "{{ .OIDCResourcePrefix }}"

    github_org_name  = "{{ .GitHubOrgName }}"
    github_repo_name = "{{ .GitHubRepoName }}"

    state_bucket_name = local.account_hcl.locals.state_bucket_name
  }
}
