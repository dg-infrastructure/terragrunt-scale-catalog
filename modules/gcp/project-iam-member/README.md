# GCP Project IAM Member Module

## Overview

This module grants one or more IAM roles to a member at the project level.

## Usage

```hcl
module "project_iam" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/project-iam-member?ref=main"

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
  "roles/storage.objectViewer",      # Read GCS bucket metadata (does not grant object-content access)
]
```

> **Note:** `roles/viewer` does not include `storage.objects.get`, so Terraform state reads require `roles/storage.objectViewer` at minimum. For state locking (`terraform plan` acquires a lock), grant `roles/storage.objectUser` scoped to the state bucket rather than at the project level.

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

## Related Resources

- [GCP Service Account Module](../service-account/) - Service accounts to grant roles to
- [GCP Custom Role Module](../custom-role/) - Custom roles that can be assigned at the project level

## References

- [GCP IAM Overview](https://cloud.google.com/iam/docs/overview)
- [GCP Predefined Roles](https://cloud.google.com/iam/docs/understanding-roles)
