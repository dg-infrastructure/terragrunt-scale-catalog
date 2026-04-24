resource "google_storage_bucket_iam_member" "bindings" {
  for_each = toset(var.roles)

  bucket = var.bucket
  role   = each.value
  member = var.member
}
