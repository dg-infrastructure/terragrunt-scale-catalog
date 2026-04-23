import {
  for_each = var.import_existing ? toset(var.roles) : toset([])
  to       = google_storage_bucket_iam_member.bindings[each.value]
  id       = "${var.bucket} ${each.value} ${var.member}"
}

resource "google_storage_bucket_iam_member" "bindings" {
  for_each = toset(var.roles)

  bucket = var.bucket
  role   = each.value
  member = var.member
}
