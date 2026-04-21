# GCP Storage Bucket IAM Member

This module grants one or more IAM roles to a member scoped to a specific GCS bucket.

## Usage

```hcl
module "bucket_iam" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/storage-bucket-iam-member?ref=v1.0.0"

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
| `roles/storage.legacyBucketReader` | `buckets.get`, `objects.list` | Read bucket IAM policy during plan |
| `roles/storage.objectAdmin` | All object permissions | Full state management (apply SA) |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `bucket` | The GCS bucket name to grant IAM permissions on | `string` | Yes |
| `member` | The IAM member to grant roles to | `string` | Yes |
| `roles` | List of IAM roles to grant on the bucket | `list(string)` | Yes |

## Outputs

This module does not produce outputs.
