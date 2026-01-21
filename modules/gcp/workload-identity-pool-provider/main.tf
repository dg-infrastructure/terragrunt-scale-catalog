resource "google_iam_workload_identity_pool_provider" "provider" {
  project                            = var.project_id
  workload_identity_pool_id          = var.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  display_name                       = var.display_name
  description                        = var.description
  disabled                           = var.disabled
  attribute_condition                = var.attribute_condition

  attribute_mapping = var.attribute_mapping

  oidc {
    issuer_uri = var.issuer_uri
  }
}
