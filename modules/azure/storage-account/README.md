# Azure Storage Account Module

## Overview

This OpenTofu module creates an Azure Storage Account. Storage accounts provide cloud storage for blobs, files, queues, and tables. In the context of Terragrunt Scale, storage accounts are commonly used for storing OpenTofu state files.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the storage account | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region where the storage account will be created | `string` | n/a | yes |
| account_tier | The performance tier of the storage account | `string` | `"Standard"` | no |
| account_replication_type | The replication type of the storage account | `string` | `"GRS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the storage account |

## Related Resources

- [Resource Group Module](../resource-group/) - Create the resource group first
- [Storage Container Module](../storage-container/) - Create containers in this storage account

## References

- [Azure Storage Accounts](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Replication Options](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)
- [OpenTofu State in Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage)
