locals {
  // Source resolution
  terragrunt_scale_catalog_url = try(values.terragrunt_scale_catalog_url, "github.com/gruntwork-io/terragrunt-scale-catalog")
  terragrunt_scale_catalog_ref = try(values.terragrunt_scale_catalog_ref, "v1.2.0")

  // Project values
  project_id     = values.project_id
  project_number = values.project_number

  // OIDC values
  oidc_resource_prefix = try(values.oidc_resource_prefix, "pipelines")

  github_token_actions_domain = try(values.github_token_actions_domain, "token.actions.githubusercontent.com")

  github_org_name  = values.github_org_name
  github_repo_name = values.github_repo_name

  issuer        = try(values.issuer, "https://${local.github_token_actions_domain}")
  deploy_branch = try(values.deploy_branch, "main")

  // Workload Identity Pool settings
  workload_identity_pool_id          = try(values.workload_identity_pool_id, "${local.oidc_resource_prefix}-github-pool")
  workload_identity_pool_provider_id = try(values.workload_identity_pool_provider_id, "${local.oidc_resource_prefix}-github-provider")

  // Attribute mapping for GitHub Actions OIDC tokens
  default_attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.ref"              = "assertion.ref"
  }

  attribute_mapping = try(values.attribute_mapping, local.default_attribute_mapping)

  // Attribute condition to restrict which identities can authenticate
  attribute_condition = try(values.attribute_condition, "assertion.repository == '${local.github_org_name}/${local.github_repo_name}'")

  // Default IAM roles for plan (read-only)
  default_plan_roles = [
    "roles/viewer",
    "roles/storage.objectViewer",
  ]

  // Default IAM roles for apply (read-write)
  default_apply_roles = [
    "roles/editor",
    "roles/storage.objectAdmin",
    "roles/iam.serviceAccountUser",
  ]

  plan_roles  = try(values.plan_roles, local.default_plan_roles)
  apply_roles = try(values.apply_roles, local.default_apply_roles)

  // Workload Identity principal formats
  // For plan: allow any workflow from the repository (principalSet with attribute filter)
  plan_member = "principalSet://iam.googleapis.com/projects/${local.project_number}/locations/global/workloadIdentityPools/${local.workload_identity_pool_id}/attribute.repository/${local.github_org_name}/${local.github_repo_name}"

  // For apply: restrict to specific branch (principal with subject)
  apply_member = "principal://iam.googleapis.com/projects/${local.project_number}/locations/global/workloadIdentityPools/${local.workload_identity_pool_id}/subject/repo:${local.github_org_name}/${local.github_repo_name}:ref:refs/heads/${local.deploy_branch}"
}

// Workload Identity Pool (shared by plan and apply)
unit "workload_identity_pool" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/workload-identity-pool?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/workload-identity-pool"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    project_id                = local.project_id
    workload_identity_pool_id = local.workload_identity_pool_id
    display_name              = "GitHub Actions Pool"
    description               = "Workload Identity Pool for GitHub Actions OIDC authentication"
  }
}

// Workload Identity Pool Provider
unit "workload_identity_pool_provider" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/workload-identity-pool-provider?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/workload-identity-pool-provider"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    workload_identity_pool_config_path = "../workload-identity-pool"

    project_id                         = local.project_id
    workload_identity_pool_provider_id = local.workload_identity_pool_provider_id
    display_name                       = "GitHub Actions Provider"
    description                        = "OIDC provider for GitHub Actions"

    issuer_uri          = local.issuer
    attribute_mapping   = local.attribute_mapping
    attribute_condition = local.attribute_condition
  }
}

// Plan Service Account
unit "plan_service_account" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/service-account?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/service-account"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    project_id   = local.project_id
    account_id   = "${local.oidc_resource_prefix}-plan"
    display_name = "Pipelines Plan Service Account"
    description  = "Service account used by Gruntwork Pipelines for plans"
  }
}

// Plan Service Account Workload Identity Binding (allows any branch/PR)
unit "plan_workload_identity_binding" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/service-account-iam-binding?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/workload-identity-binding"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_account_config_path = "../service-account"

    member = local.plan_member
  }
}

// Plan IAM Role Bindings
unit "plan_project_iam_bindings" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/project-iam-member?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/project-iam-bindings"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_account_config_path = "../service-account"

    project_id = local.project_id
    roles      = local.plan_roles
  }
}

// Apply Service Account
unit "apply_service_account" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/service-account?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/service-account"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    project_id   = local.project_id
    account_id   = "${local.oidc_resource_prefix}-apply"
    display_name = "Pipelines Apply Service Account"
    description  = "Service account used by Gruntwork Pipelines for applies and destroys"
  }
}

// Apply Service Account Workload Identity Binding (restricted to deploy branch)
unit "apply_workload_identity_binding" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/service-account-iam-binding?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/workload-identity-binding"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_account_config_path = "../service-account"

    member = local.apply_member
  }
}

// Apply IAM Role Bindings
unit "apply_project_iam_bindings" {
  source = "${local.terragrunt_scale_catalog_url}//units/gcp/oidc/project-iam-member?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/project-iam-bindings"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_account_config_path = "../service-account"

    project_id = local.project_id
    roles      = local.apply_roles
  }
}
