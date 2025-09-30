output "object_id" {
  description = "The object ID of the Entra ID service principal."
  value       = azuread_service_principal.service_principal.object_id
}

output "display_name" {
  description = "The display name of the application associated with this service principal."
  value       = azuread_service_principal.service_principal.display_name
}
