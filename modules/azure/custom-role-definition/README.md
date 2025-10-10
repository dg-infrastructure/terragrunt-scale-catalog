# Custom Role Definition Module

## Overview

This OpenTofu module creates a custom Azure RBAC role definition. Custom roles allow you to create fine-grained permissions tailored to your specific requirements, beyond what Azure's built-in roles provide.

## Features

- Create custom role definitions at subscription or resource group scope
- Define precise permissions using actions, not_actions, data_actions, and not_data_actions
- Control where the role can be assigned using assignable_scopes
- Full support for Azure RBAC permissions model

## Usage Example

```hcl
module "custom_role" {
  source = "path/to/module"

  name        = "Custom Terraform Deployer"
  description = "Custom role for Terraform deployments with limited permissions"

  actions = [
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Resources/subscriptions/resourceGroups/write",
    "Microsoft.Resources/deployments/*",
    "Microsoft.Storage/storageAccounts/read",
    "Microsoft.Storage/storageAccounts/write",
  ]

  not_actions = [
    "Microsoft.Authorization/*/Delete",
    "Microsoft.Authorization/*/Write",
  ]

  # Optional: Specify scope (defaults to current subscription)
  # scope = "/subscriptions/00000000-0000-0000-0000-000000000000"

  # Optional: Specify assignable scopes
  # assignable_scopes = [
  #   "/subscriptions/00000000-0000-0000-0000-000000000000"
  # ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the custom role definition | `string` | n/a | yes |
| scope | The scope at which the role definition is created | `string` | current subscription | no |
| description | A description of the custom role | `string` | `""` | no |
| actions | List of allowed actions | `list(string)` | `[]` | no |
| not_actions | List of denied actions | `list(string)` | `[]` | no |
| data_actions | List of allowed data actions | `list(string)` | `[]` | no |
| not_data_actions | List of denied data actions | `list(string)` | `[]` | no |
| assignable_scopes | List of scopes where the role can be assigned | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the custom role definition |
| role_definition_id | The role definition ID (GUID) of the custom role |
| name | The name of the custom role definition |
| role_definition_resource_id | The Azure resource ID of the custom role definition |

## Understanding Actions vs Data Actions

- **Actions**: Control permissions for management plane operations (e.g., creating resources, modifying settings)
- **Data Actions**: Control permissions for data plane operations (e.g., reading blob data, writing to storage)
- **Not Actions/Not Data Actions**: Explicitly deny specific operations even if they would be allowed by Actions/Data Actions

## Scope Considerations

The `scope` parameter defines where the role definition is created:

- Subscription: `/subscriptions/{subscription-id}`
- Resource Group: `/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}`

The `assignable_scopes` parameter controls where the role can be assigned. If not specified, it defaults to the creation scope.

## Related Resources

- [Entra ID Role Assignment Module](../entra-id-role-assignment/) - Assign roles (including custom roles) to principals
- [Entra ID Service Principal Module](../entra-id-service-principal/) - Create service principals to assign custom roles to

## References

- [Azure Custom Roles Documentation](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)
- [Azure Resource Provider Operations](https://learn.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations)
- [Terraform azurerm_role_definition Resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition)
