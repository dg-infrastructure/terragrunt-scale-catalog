locals {
  // Read from parent configurations instead of defining these values locally
  // so that other stacks and units in this directory can reuse the same configurations.
  project_hcl = read_terragrunt_config(find_in_parent_folders("project.hcl"))
}

stack "bootstrap" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//stacks/gcp/github/pipelines-bootstrap?ref={{ .TerragruntScaleCatalogRef }}"
  path   = "bootstrap"

  values = {
    terragrunt_scale_catalog_ref = "{{ .TerragruntScaleCatalogRef }}"

    project_id     = "{{ .GCPProjectID }}"
    project_number = "{{ .GCPProjectNumber }}"

    oidc_resource_prefix = "{{ .OIDCResourcePrefix }}"

    github_org_name  = "{{ .GitHubOrgName }}"
    github_repo_name = "{{ .GitHubRepoName }}"

    {{- if .Issuer }}
    issuer = "{{ .Issuer }}"
    {{- end }}

    {{- if .DeployBranch }}
    deploy_branch = "{{ .DeployBranch }}"
    {{- end }}

    {{- if .WorkloadIdentityPoolID }}
    workload_identity_pool_id = "{{ .WorkloadIdentityPoolID }}"
    {{- end }}

    {{- if .WorkloadIdentityPoolProviderID }}
    workload_identity_pool_provider_id = "{{ .WorkloadIdentityPoolProviderID }}"
    {{- end }}

    {{- if .PlanRoles }}
    plan_roles = {{ toJson .PlanRoles }}
    {{- end }}

    {{- if .ApplyRoles }}
    apply_roles = {{ toJson .ApplyRoles }}
    {{- end }}
  }
}
