data "azurerm_subscription" "current" {}

module "role_assignment" {
  source = "../entra-id-role-assignment"

  scope                = data.azurerm_subscription.current.id
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
  description          = var.description
}
