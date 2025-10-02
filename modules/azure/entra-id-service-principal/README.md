# Entra ID Service Principal Module

## Overview

This OpenTofu module creates a service principal for an Entra ID application. A service principal is the local representation of an application in a specific Azure tenant. It's what you assign Azure RBAC roles and permissions to, enabling the application to access Azure resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| client_id | The client ID (application ID) of the application | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| object_id | The object ID of the service principal (used for role assignments) |
| display_name | The display name of the application associated with this service principal |

## Related Resources

- [Entra ID Application Module](../entra-id-application/) - Create the application first
- [Entra ID Role Assignment Module](../entra-id-role-assignment/) - Assign roles to this service principal
- [Entra ID Federated Identity Credential Module](../entra-id-federated-identity-credential/) - Add OIDC authentication

## References

- [Service Principals Documentation](https://learn.microsoft.com/en-us/entra/identity-platform/app-objects-and-service-principals)
- [Azure RBAC](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
- [Service Principal Best Practices](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal)
