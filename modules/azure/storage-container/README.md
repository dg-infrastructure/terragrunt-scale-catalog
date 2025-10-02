# Azure Storage Container Module

## Overview

This OpenTofu module creates an Azure Storage Container (also known as a blob container) within an Azure Storage Account. Storage containers are used to organize blobs (binary large objects), and in the context of Terragrunt Scale, they're commonly used to store OpenTofu state files.

## Usage

### Example: Container for OpenTofu State

```hcl
module "state_container" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/azure/storage-container?ref=main"

  name               = "tfstate"
  storage_account_id = var.storage_account_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the storage container | `string` | n/a | yes |
| storage_account_id | The ID of the storage account | `string` | n/a | yes |
| container_access_type | The access type of the storage container | `string` | `"private"` | no |

## Outputs

This module has no outputs.

## Container Naming

See the [Azure Storage Container naming documentation](https://learn.microsoft.com/en-us/rest/api/storageservices/naming-and-referencing-containers--blobs--and-metadata#container-names) for more information.

## Using Container for OpenTofu State

### Terragrunt Configuration

After creating the container, configure Terragrunt to use it:

```hcl
# root.hcl

remote_state {
  backend = "azurerm"

  config = {
    resource_group_name  = "tofu-state-rg"
    storage_account_name = "tfstatestorage123"
    container_name       = "tfstate"  # Your container name
    key                  = "tofu.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}
```

### OpenTofu Backend Configuration

For standalone OpenTofu:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tofu-state-rg"
    storage_account_name = "tfstatestorage123"
    container_name       = "tfstate"  # Your container name
    key                  = "prod.tofu.tfstate"
  }
}
```

## Related Resources

- [Storage Account Module](../storage-account/) - Create the storage account first
- [Resource Group Module](../resource-group/) - Create the resource group

## References

- [Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [OpenTofu State in Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage)
- [Container Properties](https://learn.microsoft.com/en-us/rest/api/storageservices/create-container)
