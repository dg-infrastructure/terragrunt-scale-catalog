# GCP Workload Identity Pool

This module creates a Google Cloud Workload Identity Pool, which is used to federate external identities (like GitHub Actions) with Google Cloud.

## Usage

```hcl
module "workload_identity_pool" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/workload-identity-pool?ref=v1.0.0"

  project_id                = "my-gcp-project"
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Pool for GitHub Actions OIDC authentication"
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project_id` | The GCP project ID | `string` | Yes |
| `workload_identity_pool_id` | The ID of the pool (4-32 chars, lowercase, digits, hyphens) | `string` | Yes |
| `display_name` | Display name for the pool | `string` | Yes |
| `description` | Description of the pool | `string` | No |
| `disabled` | Whether the pool is disabled | `bool` | No |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The resource ID of the pool |
| `name` | The resource name of the pool |
| `workload_identity_pool_id` | The pool ID |
| `state` | The state of the pool |
