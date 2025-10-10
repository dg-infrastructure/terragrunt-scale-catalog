data "azurerm_subscription" "current" {}

resource "azurerm_role_definition" "role" {
  name        = var.name
  scope       = coalesce(var.scope, data.azurerm_subscription.current.id)
  description = var.description

  permissions {
    actions          = var.actions
    not_actions      = var.not_actions
    data_actions     = var.data_actions
    not_data_actions = var.not_data_actions
  }

  assignable_scopes = var.assignable_scopes
}

