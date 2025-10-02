# IAM Role Policy Attachment Module

## Overview

This OpenTofu module attaches an IAM policy to an IAM role. This is a simple but essential module for granting permissions to IAM roles used in OIDC-authenticated CI/CD pipelines.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| role_name | The name of the IAM role to attach the policy to | `string` | n/a | yes |
| policy_arn | The ARN of the IAM policy to attach | `string` | n/a | yes |

## Outputs

This module has no outputs.

## Related Resources

- [IAM OIDC Role Module](../iam-oidc-role/) - Create the role to attach policies to
- [IAM Policy Module](../iam-policy/) - Create custom policies to attach
- [IAM OpenID Connect Provider Module](../iam-openid-connect-provider/) - Create the OIDC provider

## References

- [AWS IAM Role Policy Attachment Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage-attach-detach.html)
- [AWS Managed Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html)
