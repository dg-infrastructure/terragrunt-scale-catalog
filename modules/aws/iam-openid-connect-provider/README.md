# IAM OpenID Connect Provider Module

## Overview

This OpenTofu module creates an AWS IAM OpenID Connect (OIDC) identity provider. The OIDC provider establishes trust between AWS and an external identity provider (like GitHub Actions or GitLab CI), allowing workloads running in those systems to assume IAM roles without using long-lived credentials.

## Usage

### Example: GitHub Actions OIDC Provider

```hcl
module "github_oidc_provider" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/iam-openid-connect-provider?ref=main"

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]
}
```

### Example: GitLab OIDC Provider

```hcl
module "gitlab_oidc_provider" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/iam-openid-connect-provider?ref=main"

  url = "https://gitlab.com"

  client_id_list = [
    "https://gitlab.com"
  ]
}
```

### Example: GitHub Enterprise Server

```hcl
module "github_enterprise_oidc_provider" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/aws/iam-openid-connect-provider?ref=main"

  url = "https://github.mycompany.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| url | The URL of the OIDC identity provider | `string` | n/a | yes |
| client_id_list | The list of client IDs (audiences) that can use this provider | `list(string)` | n/a | yes |
| tags | Tags to apply to the OIDC provider | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the OIDC identity provider |

## How It Works

1. **Provider Creation**: AWS creates an OIDC identity provider resource that trusts the external identity provider
2. **Thumbprint Retrieval**: AWS automatically fetches the TLS certificate thumbprint from the provider URL
3. **Token Validation**: When a role assumption request arrives, AWS validates the OIDC token signature using the provider's public keys
4. **Trust Establishment**: IAM roles can now reference this provider in their trust policies

## Common OIDC Provider URLs

| Provider | URL | Client ID |
|----------|-----|-----------|
| GitHub Actions | `https://token.actions.githubusercontent.com` | `sts.amazonaws.com` |
| GitLab.com | `https://gitlab.com` | `https://gitlab.com` |
| GitLab Self-Managed | `https://gitlab.yourdomain.com` | `https://gitlab.yourdomain.com` |
| GitHub Enterprise Server | `https://github.yourdomain.com` | `sts.amazonaws.com` |

## Important Notes

### One Provider Per URL

You are only allowed one OIDC provider per URL in your AWS account. For example:

- One provider for all GitHub Actions workflows
- One provider for all GitLab CI pipelines

Multiple repositories/projects can share the same OIDC provider by using different IAM roles with different trust policies.

### Client ID (Audience)

The client ID list specifies which audiences are allowed. The audience claim in the OIDC token must match one of these values:

- GitHub Actions typically uses `sts.amazonaws.com`
- GitLab typically uses the GitLab instance URL

## Related Resources

- [IAM OIDC Role Module](../iam-oidc-role/) - Create roles that use this provider
- [IAM Policy Module](../iam-policy/) - Create policies to attach to OIDC roles
- [IAM Role Policy Attachment Module](../iam-role-policy-attachment/) - Attach policies to roles

## References

- [AWS IAM OIDC Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [GitHub Actions OIDC](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [GitLab OIDC](https://docs.gitlab.com/ee/ci/cloud_services/aws/)
