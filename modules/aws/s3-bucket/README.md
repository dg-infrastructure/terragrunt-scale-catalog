# S3 Bucket Module

## Overview

This OpenTofu module creates a basic AWS S3 bucket. This module is designed to help users test and understand the Terragrunt Scale workflow with a simple, non-destructive resource. It provides a minimal implementation suitable for learning and experimentation.

## Usage

```hcl
module "s3_bucket" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/s3-bucket?ref=main"

  name = "my-test-bucket"
}
```

### Example: Basic Bucket for Testing

```hcl
module "test_bucket" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/s3-bucket?ref=main"

  name = "terragrunt-scale-test-bucket-${random_id.bucket_suffix.hex}"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the S3 bucket. Must be globally unique across all AWS accounts | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the S3 bucket |

## Important Notes

- **Bucket Name Uniqueness**: S3 bucket names must be globally unique across all AWS accounts. If you encounter a naming conflict, try adding a random suffix or using a unique prefix.
- **Testing Purpose**: This module creates a basic bucket without additional features like versioning, encryption, or lifecycle policies. It's intended for testing Terragrunt Scale workflows.
- **Bucket Naming Rules**:
  - Must be between 3 and 63 characters long
  - Can only contain lowercase letters, numbers, dots (.), and hyphens (-)
  - Must begin and end with a letter or number
  - Must not be formatted as an IP address (e.g., 192.168.1.1)

## References

- [AWS S3 Bucket Documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-buckets-s3.html)
- [AWS S3 Bucket Naming Rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)
