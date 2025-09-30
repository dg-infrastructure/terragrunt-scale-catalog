output "id" {
  description = "The ID of the Entra ID application."
  value       = azuread_application.app.id
}

output "client_id" {
  description = "The client ID of the Entra ID application."
  value       = azuread_application.app.client_id
}

output "display_name" {
  description = "The display name of the Entra ID application."
  value       = azuread_application.app.display_name
}
