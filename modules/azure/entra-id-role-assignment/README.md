# Entra ID Role Assignment Module

## Overview

This OpenTofu module assigns an Azure RBAC role to a principal (service principal, user, or group) at a specific scope. This is essential for granting permissions to service principals used in CI/CD pipelines.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| scope | The scope at which the role assignment applies (resource ID) | `string` | n/a | yes |
| role_definition_name | The name of the role definition to assign | `string` | n/a | yes |
| principal_id | The object ID of the principal (service principal, user, or group) | `string` | n/a | yes |
| description | The description for the role assignment | `string` | n/a | yes |

## Outputs

This module has no outputs.

## Related Resources

- [Entra ID Service Principal Module](../entra-id-service-principal/) - Create the service principal to assign roles to
- [Entra ID Role Assignment to Subscription Module](../entra-id-role-assignment-to-sub/) - Simplified subscription-level assignments

## References

- [Azure RBAC Documentation](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
- [Built-in Roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
- [Assign Azure Roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments)
