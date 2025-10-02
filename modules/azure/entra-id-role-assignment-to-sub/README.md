# Entra ID Role Assignment to Subscription Module

## Overview

This OpenTofu module is a convenience wrapper around the [Entra ID Role Assignment Module](../entra-id-role-assignment/) that specifically assigns roles at the subscription scope. It automatically fetches the current subscription ID and assigns the specified role to the principal.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| role_definition_name | The name of the role definition to assign to the service principal | `string` | n/a | yes |
| principal_id | The object ID of the Entra ID service principal | `string` | n/a | yes |
| description | The description for the role assignment | `string` | n/a | yes |

## Outputs

This module has no outputs.

## Related Resources

- [Entra ID Role Assignment Module](../entra-id-role-assignment/) - Base module for any scope
- [Entra ID Service Principal Module](../entra-id-service-principal/) - Create service principals

## References

- [Azure RBAC Scopes](https://learn.microsoft.com/en-us/azure/role-based-access-control/scope-overview)
- [Subscription-level Assignments](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal-subscription-admin)
- [Least Privilege](https://learn.microsoft.com/en-us/azure/role-based-access-control/best-practices)
