# GCP Custom Role

This module creates a GCP project-level custom IAM role with a specified set of permissions.

## Usage

```hcl
module "custom_role" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/custom-role?ref=v1.0.0"

  project_id  = "my-gcp-project"
  role_id     = "pipelines_state_bucket"
  title       = "Pipelines State Bucket Role"
  description = "Least-privilege role for plan SA state bucket access"

  permissions = [
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list",
    "storage.objects.update",
    "storage.buckets.getIamPolicy",
  ]
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project_id` | GCP project ID in which to create the custom role | `string` | Yes |
| `role_id` | Role ID, unique within the project; must match `[a-zA-Z0-9_]{3,64}` | `string` | Yes |
| `title` | Human-readable title for the role | `string` | Yes |
| `description` | Description of the role | `string` | No |
| `permissions` | List of IAM permissions to include | `list(string)` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| `role_name` | Fully qualified role name (`projects/PROJECT_ID/roles/ROLE_ID`) |
| `role_id` | The role ID |
