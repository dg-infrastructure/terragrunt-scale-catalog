# GCP Service Account

This module creates a Google Cloud Service Account that can be used with Workload Identity Federation to allow external identities to impersonate it.

## Usage

```hcl
module "service_account" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/service-account?ref=v1.0.0"

  project_id   = "my-gcp-project"
  account_id   = "pipelines-plan"
  display_name = "Pipelines Plan Service Account"
  description  = "Service account for Terragrunt plan operations"
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project_id` | The GCP project ID | `string` | Yes |
| `account_id` | The account ID (6-30 chars, lowercase, digits, hyphens) | `string` | Yes |
| `display_name` | Display name for the service account | `string` | Yes |
| `description` | Description of the service account | `string` | No |
| `disabled` | Whether the service account is disabled | `bool` | No |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The resource ID of the service account |
| `name` | The fully-qualified name of the service account |
| `email` | The email address of the service account |
| `unique_id` | The unique ID of the service account |
| `member` | The IAM member string (`serviceAccount:email`) |
