# IAM Policy Module

## Overview

This OpenTofu module creates an AWS IAM policy. IAM policies define permissions that can be attached to IAM roles, users, or groups. This module is commonly used to create policies for OIDC-authenticated CI/CD pipelines.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the IAM policy | `string` | n/a | yes |
| policy | The JSON policy document | `string` | n/a | yes |
| path | The path for the IAM policy | `string` | `"/"` | no |
| description | The description of the IAM policy | `string` | `""` | no |
| tags | Tags to apply to the IAM policy | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the IAM policy |

## Policy Best Practices

### 1. Principle of Least Privilege

Grant only the minimum permissions required:

```hcl
# Good: Specific permissions
policy = jsonencode({
  Statement = [{
    Effect   = "Allow"
    Action   = ["s3:GetObject", "s3:PutObject"]
    Resource = "arn:aws:s3:::specific-bucket/*"
  }]
})

# Bad: Overly permissive
policy = jsonencode({
  Statement = [{
    Effect   = "Allow"
    Action   = "*"
    Resource = "*"
  }]
})
```

### 2. Use Conditions

Add conditions to further restrict access:

```hcl
policy = jsonencode({
  Statement = [{
    Effect   = "Allow"
    Action   = "s3:*"
    Resource = "arn:aws:s3:::my-bucket/*"
    Condition = {
      StringEquals = {
        "aws:PrincipalOrgID" = "o-xxxxxxxxxx"
      }
    }
  }]
})
```

### 3. Separate Plan and Apply Policies

Use different policies for read-only (plan) and write (apply) operations:

- **Plan Policy**: Read-only access (Describe*, Get*, List*)
- **Apply Policy**: Full access needed to create/update/delete resources

## Related Resources

- [IAM OIDC Role Module](../iam-oidc-role/) - Roles that policies can be attached to
- [IAM Role Policy Attachment Module](../iam-role-policy-attachment/) - Attach this policy to roles

## References

- [AWS IAM Policy Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [IAM Policy Elements Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html)
- [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html)
