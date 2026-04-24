# GCP Storage Bucket Module

## Overview

This OpenTofu module creates a Google Cloud Storage (GCS) bucket. GCS buckets provide object storage for a wide range of use cases including static assets, backups, and data archival.

## Usage

```hcl
module "state_bucket" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/storage-bucket?ref=main"

  project_id = "my-gcp-project"
  name       = "my-storage-bucket"
  location   = "us-central1"

  versioning_enabled = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID where the bucket will be created | `string` | n/a | yes |
| name | The name of the bucket. Must be globally unique across all GCP projects | `string` | n/a | yes |
| location | The GCS location where the bucket will be created (e.g. US, EU, ASIA, us-central1) | `string` | n/a | yes |
| storage_class | The storage class of the bucket. Valid values are STANDARD, NEARLINE, COLDLINE, and ARCHIVE | `string` | `"STANDARD"` | no |
| versioning_enabled | Whether to enable versioning on the bucket | `bool` | `true` | no |
| force_destroy | Whether to delete all objects in the bucket when the bucket is destroyed | `bool` | `false` | no |
| uniform_bucket_level_access | Whether to enable uniform bucket-level access, which disables object-level ACLs | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the bucket |
| url | The base URL of the bucket in the format gs://<bucket-name> |
| self_link | The URI of the bucket |

## Important Notes

- **Bucket Name Uniqueness**: GCS bucket names must be globally unique across all GCP projects. If you encounter a naming conflict, try adding a unique prefix or suffix.
- **Bucket Naming Rules**:
  - Must be between 3 and 63 characters long
  - Can only contain lowercase letters, numbers, and hyphens (-)
  - Must begin and end with a letter or number
  - Must not be formatted as an IP address (e.g., 192.168.1.1)
- **Uniform Bucket-Level Access**: Enabled by default. This is the recommended setting as it simplifies permission management by disabling legacy object-level ACLs.
- **Versioning**: Enabled by default. Recommended when using the bucket for OpenTofu state storage to protect against accidental deletions.

## References

- [GCS Bucket Documentation](https://cloud.google.com/storage/docs/creating-buckets)
- [GCS Bucket Naming Guidelines](https://cloud.google.com/storage/docs/naming-buckets)
- [GCS Storage Classes](https://cloud.google.com/storage/docs/storage-classes)
- [OpenTofu State in GCS](https://opentofu.org/docs/language/settings/backends/gcs/)
