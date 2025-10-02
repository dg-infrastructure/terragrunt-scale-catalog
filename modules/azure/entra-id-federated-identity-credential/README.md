# Entra ID Federated Identity Credential Module

## Overview

This OpenTofu module creates a federated identity credential for an Entra ID application. Federated identity credentials enable workload identity federation using OpenID Connect (OIDC), allowing external workloads (like GitHub Actions or GitLab CI) to authenticate to Azure without using secrets or certificates.

This module creates **static** federated identity credentials with an exact subject match. For wildcard pattern matching, see the [Flexible Federated Identity Credential Module](../entra-id-flexible-federated-identity-credential/).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| application_id | The object ID of the Entra ID application | `string` | n/a | yes |
| display_name | The display name for the federated identity credential | `string` | n/a | yes |
| description | The description for the federated identity credential | `string` | n/a | yes |
| audiences | The audiences that can appear in the external token | `list(string)` | n/a | yes |
| issuer | The URL of the external identity provider | `string` | n/a | yes |
| subject | The identifier of the external identity (exact match) | `string` | n/a | yes |

## Outputs

This module has no outputs.

## Subject Patterns

### GitHub Actions

```hcl
# Specific branch
subject = "repo:org/repo:ref:refs/heads/main"

### GitLab CI

```hcl
# Specific branch
subject = "project_path:group/project:ref_type:branch:ref:main"
```

## Static vs Flexible Credentials

### Static (This Module)

- **Exact match** of subject required
- Use for **apply/deploy** operations
- Restricts to specific branches
- More secure for production

```hcl
# Only the main branch of my-org/my-repo can authenticate
subject = "repo:my-org/my-repo:ref:refs/heads/main"
```

### Flexible

See the [Flexible Federated Identity Credential Module](../entra-id-flexible-federated-identity-credential/) for more information.

## Common Audiences

| Provider | Audience |
|----------|----------|
| GitHub Actions | `api://AzureADTokenExchange` |
| GitLab.com | `https://gitlab.com` |
| GitLab Self-Managed | `https://gitlab.yourdomain.com` |

## Common Issuers

| Provider | Issuer |
|----------|--------|
| GitHub Actions | `https://token.actions.githubusercontent.com` |
| GitHub Enterprise | `https://github.yourdomain.com` |
| GitLab.com | `https://gitlab.com` |
| GitLab Self-Managed | `https://gitlab.yourdomain.com` |

## Related Resources

- [Entra ID Application Module](../entra-id-application/) - Create the application
- [Entra ID Service Principal Module](../entra-id-service-principal/) - Create the service principal
- [Entra ID Flexible Federated Identity Credential Module](../entra-id-flexible-federated-identity-credential/) - Use pattern matching

## References

- [Workload Identity Federation](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation)
- [GitHub Actions with Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitLab with Azure](https://docs.gitlab.com/ee/ci/cloud_services/azure/)
