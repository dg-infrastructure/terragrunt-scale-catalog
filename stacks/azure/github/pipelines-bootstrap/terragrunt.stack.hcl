locals {
  // Source resolution
  terragrunt_scale_catalog_url = try(values.terragrunt_scale_catalog_url, "github.com/gruntwork-io/terragrunt-scale-catalog")
  terragrunt_scale_catalog_ref = try(values.terragrunt_scale_catalog_ref, "v1.0.0")

  // State values
  location = values.location

  state_resource_group_name    = values.state_resource_group_name
  state_storage_account_name   = values.state_storage_account_name
  state_storage_container_name = try(values.state_storage_container_name, "tfstate")

  // OIDC values
  oidc_resource_prefix = try(values.oidc_resource_prefix, "pipelines")

  github_token_actions_domain = try(values.github_token_actions_domain, "token.actions.githubusercontent.com")

  github_org_name  = values.github_org_name
  github_repo_name = values.github_repo_name

  audiences            = try(values.audiences, ["api://AzureADTokenExchange"])
  issuer               = try(values.issuer, "https://${local.github_token_actions_domain}")
  deploy_branch        = try(values.deploy_branch, "main")

  plan_service_principal_to_sub_role_definition_assignment = try(
    values.plan_service_principal_to_sub_role_definition_assignment,
    "Reader",
  )
  plan_service_principal_to_state_role_definition_assignment = try(
    values.plan_service_principal_to_state_role_definition_assignment,
    "Contributor",
  )
  apply_service_principal_to_state_role_definition_assignment = try(
    values.apply_service_principal_to_state_role_definition_assignment,
    "Contributor",
  )
}

// State units

unit "resource_group" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/state/resource-group?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "state/resource-group"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    name     = local.state_resource_group_name
    location = local.location
  }
}

unit "storage_account" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/state/storage-account?ref=${local.terragrunt_scale_catalog_ref}"

  path = "state/storage-account"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    resource_group_config_path = "../resource-group"

    name     = local.state_storage_account_name
    location = local.location
  }
}

unit "storage_container" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/state/storage-container?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "state/storage-container"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    storage_account_config_path = "../storage-account"

    name = local.state_storage_container_name
  }
}

// OIDC units

// Plan units

unit "plan_app" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/entra-id-application?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/app"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    display_name = "${local.oidc_resource_prefix}-plan"
    description  = "Entra ID application used by Gruntwork Pipelines for plans"
  }
}

unit "plan_service_principal" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/entra-id-service-principal?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/service-principal"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    app_config_path = "../app"
  }
}

unit "plan_flexible_federated_identity_credential" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/entra-id-flexible-federated-identity-credential?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/flexible-federated-identity-credential"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    app_config_path = "../app"

    display_name = "${local.oidc_resource_prefix}-plan"
    description  = "Entra ID flexible federated identity credential used by Gruntwork Pipelines for plans"

    audiences = local.audiences
    issuer    = local.issuer

    claims_matching_expression_value = "claims['sub'] matches 'repo:${local.github_org_name}/${local.github_repo_name}:*'"
  }
}

unit "plan_service_principal_to_sub_reader_role_assignment" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/service-principal-to-sub-role-assignment?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/service-principal-to-sub-reader-role-assignment"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_principal_config_path = "../service-principal"

    role_definition_name = local.plan_service_principal_to_sub_role_definition_assignment
    description          = "Assign Reader role to service principal at the subscription scope"
  }
}

unit "plan_service_principal_to_state_contributor_role_assignment" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/service-principal-to-scope-role-assignment?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/plan/service-principal-to-state-contributor-role-assignment"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_principal_config_path = "../service-principal"
    scope_config_path             = "../../../state/storage-account"

    role_definition_name = local.plan_service_principal_to_state_role_definition_assignment
    description          = "Assign Contributor role to service principal at the state scope"
  }
}

// Apply units

unit "apply_app" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/entra-id-application?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/app"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    display_name = "${local.oidc_resource_prefix}-apply"
    description  = "Entra ID application used by Gruntwork Pipelines for applies and destroys"
  }
}

unit "apply_service_principal" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/entra-id-service-principal?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/service-principal"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    app_config_path = "../app"
  }
}

unit "apply_federated_identity_credential" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/entra-id-federated-identity-credential?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/federated-identity-credential"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    app_config_path = "../app"

    display_name = "${local.oidc_resource_prefix}-apply"
    description  = "Entra ID federated identity credential used by Gruntwork Pipelines for applies and destroys"

    audiences = local.audiences
    issuer    = local.issuer

    subject = "repo:${local.github_org_name}/${local.github_repo_name}:ref:refs/heads/${local.deploy_branch}"
  }
}

unit "apply_service_principal_to_sub_contributor_role_assignment" {
  source = "${local.terragrunt_scale_catalog_url}//units/azure/oidc/service-principal-to-sub-role-assignment?ref=${local.terragrunt_scale_catalog_ref}"
  path   = "oidc/apply/service-principal-to-sub-contributor-role-assignment"

  values = {
    base_url = local.terragrunt_scale_catalog_url
    ref      = local.terragrunt_scale_catalog_ref

    service_principal_config_path = "../service-principal"

    role_definition_name = local.apply_service_principal_to_state_role_definition_assignment
    description          = "Assign Contributor role to service principal at the subscription scope"
  }
}
