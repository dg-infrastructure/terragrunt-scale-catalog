# IAM OIDC Role Module

## Overview

This OpenTofu module creates an AWS IAM role with an OIDC (OpenID Connect) trust policy. This role allows external identity providers (like GitHub Actions or GitLab CI) to assume the role using OIDC tokens, eliminating the need for long-lived AWS credentials.

## Usage

```hcl
module "oidc_role" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/iam-oidc-role?ref=main"

  name              = "github-actions-role"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"

  # Subject claim identifies which workflows can assume this role
  sub_key   = "token.actions.githubusercontent.com:sub"
  sub_value = "repo:my-org/my-repo:ref:refs/heads/main"

  # Audience claim
  aud_key   = "token.actions.githubusercontent.com:aud"
  aud_value = "sts.amazonaws.com"

  # Use StringEquals for exact matching (recommended for apply/deploy roles)
  condition_operator = "StringEquals"
}
```

### Example: Role for GitHub Actions Plans (Any Branch)

```hcl
module "plan_role" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/iam-oidc-role?ref=main"

  name              = "github-actions-plan-role"
  oidc_provider_arn = aws_iam_openid_connect_provider.github.arn

  # Allow any branch to run plans
  sub_key   = "token.actions.githubusercontent.com:sub"
  sub_value = "repo:my-org/my-repo:*"

  aud_key   = "token.actions.githubusercontent.com:aud"
  aud_value = "sts.amazonaws.com"

  # Use StringLike for pattern matching
  condition_operator = "StringLike"
}
```

### Example: Role for GitHub Actions Applies (Main Branch Only)

```hcl
module "apply_role" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/iam-oidc-role?ref=main"

  name              = "github-actions-apply-role"
  oidc_provider_arn = aws_iam_openid_connect_provider.github.arn

  # Only allow main branch to run applies
  sub_key   = "token.actions.githubusercontent.com:sub"
  sub_value = "repo:my-org/my-repo:ref:refs/heads/main"

  aud_key   = "token.actions.githubusercontent.com:aud"
  aud_value = "sts.amazonaws.com"

  # Use StringEquals for exact matching
  condition_operator = "StringEquals"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the IAM role | `string` | n/a | yes |
| oidc_provider_arn | The ARN of the OIDC provider | `string` | n/a | yes |
| sub_key | The key for the subject claim condition | `string` | n/a | yes |
| sub_value | The value for the subject claim condition | `string` | n/a | yes |
| aud_key | The key for the audience claim condition | `string` | n/a | yes |
| path | The path of the IAM role | `string` | `"/"` | no |
| aud_value | The value for the audience claim condition | `string` | `"sts.amazonaws.com"` | no |
| condition_operator | The operator for comparing claims (use StringEquals for applies, StringLike for plans) | `string` | `"StringEquals"` | no |
| max_session_duration | The maximum session duration in seconds for the role | `number` | `43200` (12 hours) | no |
| permissions_boundary | The ARN of the permissions boundary to attach to the role | `string` | `null` | no |
| tags | Tags to apply to the IAM role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the IAM role |
| name | The name of the IAM role |

## How OIDC Authentication Works

1. A GitHub Action or GitLab CI job requests an OIDC token from the CI/CD provider
2. The CI/CD provider issues a signed JWT token with claims (subject, audience, etc.)
3. The workflow uses this token to call AWS STS AssumeRoleWithWebIdentity
4. AWS validates the token signature against the OIDC provider's public keys
5. AWS checks the token claims against the role's trust policy conditions
6. If validation succeeds, AWS issues temporary credentials for the role

## Condition Operators

- **StringEquals**: Requires exact match. Use for apply/deploy roles restricted to specific branches.
- **StringLike**: Allows wildcard matching with `*`. Use for plan roles that should work from any branch.

## Security Best Practices

1. **Use StringEquals for apply roles**: Restrict deployment permissions to specific branches
2. **Use StringLike for plan roles**: Allow read-only operations from any branch
3. **Implement least privilege**: Attach only necessary policies to the role
4. **Use permissions boundaries**: Limit maximum permissions the role can have
5. **Set appropriate session duration**: Use shorter durations for sensitive operations
6. **Monitor role usage**: Enable CloudTrail to audit role assumptions

## Related Resources

- [AWS IAM OIDC Provider Module](../iam-openid-connect-provider/)
- [AWS IAM Policy Module](../iam-policy/)
- [AWS IAM Role Policy Attachment Module](../iam-role-policy-attachment/)

## References

- [AWS IAM OIDC Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [GitHub Actions OIDC](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- [GitLab OIDC](https://docs.gitlab.com/ee/ci/cloud_services/)
