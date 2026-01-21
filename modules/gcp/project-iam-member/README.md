# GCP Project IAM Member

This module grants one or more IAM roles to a member at the project level.

## Usage

```hcl
module "project_iam" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/project-iam-member?ref=v1.0.0"

  project_id = "my-gcp-project"
  member     = "serviceAccount:pipelines-plan@my-project.iam.gserviceaccount.com"

  roles = [
    "roles/viewer",
    "roles/storage.objectViewer",
  ]
}
```

## Common Roles for CI/CD

### Plan (Read-Only)

```hcl
roles = [
  "roles/viewer",                    # Read-only access to most resources
  "roles/storage.objectViewer",      # Read state files from GCS
]
```

### Apply (Read-Write)

```hcl
roles = [
  "roles/editor",                    # Edit access to most resources
  "roles/storage.objectAdmin",       # Manage state files in GCS
  "roles/iam.serviceAccountUser",    # Use other service accounts
]
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project_id` | The GCP project ID | `string` | Yes |
| `member` | The IAM member to grant roles to | `string` | Yes |
| `roles` | List of IAM roles to grant | `list(string)` | Yes |

## Outputs

This module does not produce outputs.
