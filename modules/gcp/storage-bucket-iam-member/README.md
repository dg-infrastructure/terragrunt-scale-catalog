# GCP Storage Bucket IAM Member Module

## Overview

This module grants one or more IAM roles to a member scoped to a specific GCS bucket.

## Usage

```hcl
module "bucket_iam" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/storage-bucket-iam-member?ref=main"

  bucket = "my-terraform-state-bucket"
  member = "serviceAccount:pipelines-plan@my-project.iam.gserviceaccount.com"

  roles = [
    "roles/storage.objectUser",
  ]
}
```

## Common Roles

| Role | Permissions | Use case |
|------|-------------|----------|
| `roles/storage.objectViewer` | `objects.get`, `objects.list` | Read-only state access |
| `roles/storage.objectUser` | `objects.create`, `objects.delete`, `objects.get`, `objects.list` | State read + locking (plan SA) |
| `roles/storage.objectAdmin` | All object permissions | Full state management (apply SA) |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `bucket` | The GCS bucket name to grant IAM permissions on | `string` | Yes |
| `member` | The IAM member to grant roles to | `string` | Yes |
| `roles` | List of IAM roles to grant on the bucket | `list(string)` | Yes |
| `import_existing` | Set to true to import existing storage bucket IAM bindings into Terraform state rather than creating them | `bool` | No |

## Outputs

This module does not produce outputs.

## Related Resources

- [GCP Storage Bucket Module](../storage-bucket/) - The bucket to grant permissions on
- [GCP Service Account Module](../service-account/) - Service accounts to grant bucket access to

## References

- [GCP Cloud Storage IAM](https://cloud.google.com/storage/docs/access-control/iam)
- [GCP Cloud Storage IAM Roles](https://cloud.google.com/storage/docs/access-control/iam-roles)
