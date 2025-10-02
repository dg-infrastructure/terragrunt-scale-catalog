# Azure Resource Group Module

## Overview

This OpenTofu module creates an Azure Resource Group. Resource groups are containers that hold related Azure resources, providing a logical grouping for management, monitoring, and access control.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region where the resource group will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the resource group |

## Related Resources

- [Storage Account Module](../storage-account/) - Create storage accounts in the resource group
- [Storage Container Module](../storage-container/) - Create containers in storage accounts

## References

- [Azure Resource Groups](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview#resource-groups)
- [Resource Group Best Practices](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview#resource-groups)
- [Azure Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
