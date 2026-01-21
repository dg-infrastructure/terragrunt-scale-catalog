# GCP Workload Identity Pool Provider

This module creates a Workload Identity Pool Provider for OIDC authentication. The provider configures how external identities (like GitHub Actions) can authenticate to Google Cloud.

## Usage

```hcl
module "workload_identity_pool_provider" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/workload-identity-pool-provider?ref=v1.0.0"

  project_id                         = "my-gcp-project"
  workload_identity_pool_id          = "github-pool"
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Actions Provider"
  description                        = "OIDC provider for GitHub Actions"

  issuer_uri = "https://token.actions.githubusercontent.com"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.ref"        = "assertion.ref"
  }

  attribute_condition = "assertion.repository == 'my-org/my-repo'"
}
```

## GitHub Actions Attribute Mapping

For GitHub Actions OIDC, the following attribute mappings are commonly used:

| Google Attribute | GitHub Claim | Description |
|-----------------|--------------|-------------|
| `google.subject` | `assertion.sub` | The subject claim (e.g., `repo:org/repo:ref:refs/heads/main`) |
| `attribute.actor` | `assertion.actor` | The GitHub user who triggered the workflow |
| `attribute.repository` | `assertion.repository` | The repository (e.g., `my-org/my-repo`) |
| `attribute.repository_owner` | `assertion.repository_owner` | The repository owner (org or user) |
| `attribute.ref` | `assertion.ref` | The git ref (e.g., `refs/heads/main`) |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project_id` | The GCP project ID | `string` | Yes |
| `workload_identity_pool_id` | The pool ID to add the provider to | `string` | Yes |
| `workload_identity_pool_provider_id` | The provider ID | `string` | Yes |
| `display_name` | Display name for the provider | `string` | Yes |
| `issuer_uri` | The OIDC issuer URI | `string` | Yes |
| `attribute_mapping` | Map of Google attributes to external claims | `map(string)` | Yes |
| `description` | Description of the provider | `string` | No |
| `disabled` | Whether the provider is disabled | `bool` | No |
| `attribute_condition` | CEL expression to restrict authentication | `string` | No |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The resource ID of the provider |
| `name` | The resource name of the provider |
| `workload_identity_pool_provider_id` | The provider ID |
| `state` | The state of the provider |
