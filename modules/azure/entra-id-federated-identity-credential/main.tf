resource "azuread_application_federated_identity_credential" "federated_identity_credential" {
  application_id = var.application_id
  display_name   = var.display_name
  description    = var.description
  audiences      = var.audiences
  issuer         = var.issuer
  subject        = var.subject
}
