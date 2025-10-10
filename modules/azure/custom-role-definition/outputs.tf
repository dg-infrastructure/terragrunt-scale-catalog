output "id" {
  description = "The ID of the custom role definition."
  value       = azurerm_role_definition.role.id
}

output "role_definition_id" {
  description = "The role definition ID (GUID) of the custom role."
  value       = azurerm_role_definition.role.role_definition_id
}

output "name" {
  description = "The name of the custom role definition."
  value       = azurerm_role_definition.role.name
}

output "role_definition_resource_id" {
  description = "The Azure resource ID of the custom role definition."
  value       = azurerm_role_definition.role.role_definition_resource_id
}

