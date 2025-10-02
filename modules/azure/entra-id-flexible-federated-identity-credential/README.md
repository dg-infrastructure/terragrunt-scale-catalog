# Entra ID Flexible Federated Identity Credential Module

## Overview

This OpenTofu module creates a flexible federated identity credential for an Entra ID application using Azure's Beta API. Flexible credentials use claim matching expressions, allowing wildcard pattern matching in the subject claim. This is particularly useful for CI/CD scenarios where you want to allow authentication from any branch or pull request for read-only operations.

**Note**: This module uses the Azure REST API (Beta) via `az rest` command, as the OpenTofu provider does not support flexible federated credentials natively yet. See ([#1591](https://github.com/hashicorp/terraform-provider-azuread/issues/1591) for more information). This module should be considered a temporary workaround until the OpenTofu provider supports flexible federated credentials natively.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| application_id | The object ID of the Entra ID application | `string` | n/a | yes |
| display_name | The display name for the federated identity credential | `string` | n/a | yes |
| issuer | The URL of the external identity provider | `string` | n/a | yes |
| audiences | The audiences that can appear in the external token | `list(string)` | n/a | yes |
| claims_matching_expression_value | The expression to use when comparing claims in the token | `string` | n/a | yes |

## Outputs

This module has no outputs.

## Prerequisites

This module requires:

- **Azure CLI** installed and available in PATH
- **Authenticated Azure CLI session** (`az login`)
- Permissions to manage applications in Entra ID

## Claim Matching Expressions

### Syntax

```text
claims['claim_name'] matches 'pattern'
```

The `matches` operator supports wildcard `*` for pattern matching.

### Common Patterns

#### GitHub Actions

```hcl
# Any branch
claims_matching_expression_value = "claims['sub'] matches 'repo:org/repo:*'"
```

#### GitLab CI

```hcl
# Any branch
claims_matching_expression_value = "claims['sub'] matches 'project_path:group/project:*'"
```

## How It Works

This module uses a `null_resource` with local-exec provisioners to:

1. **Create**: POST to Azure Graph API Beta endpoint to create the credential
2. **Destroy**: GET the credential ID, then DELETE it

## Static vs Flexible Credentials

| Feature | Static (federated-identity-credential) | Flexible (this module) |
|---------|---------------------------------------|------------------------|
| Subject Matching | Exact match only | Wildcard pattern matching |
| Use Case | Apply/Deploy (specific branches) | Plan (any branch) |
| Security | More restrictive | More permissive |
| API | GA (azuread provider) | Beta (REST API) |

### When to Use Each

**Use Static** (federated-identity-credential module) for:

- Apply/destroy operations

**Use Flexible** (this module) for:

- Plan operations

## Related Resources

- [Entra ID Application Module](../entra-id-application/) - Create the application
- [Entra ID Service Principal Module](../entra-id-service-principal/) - Create the service principal
- [Entra ID Federated Identity Credential Module](../entra-id-federated-identity-credential/) - Static credentials

## References

- [Workload Identity Federation](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation)
- [Azure Graph API Beta](https://learn.microsoft.com/en-us/graph/api/overview)
- [Azure CLI REST Command](https://learn.microsoft.com/en-us/cli/azure/reference-index#az-rest)
