data "azuread_client_config" "current" {}

resource "azuread_service_principal" "service_principal" {
  client_id = var.client_id

  app_role_assignment_required = true

  owners = [data.azuread_client_config.current.object_id]
}
