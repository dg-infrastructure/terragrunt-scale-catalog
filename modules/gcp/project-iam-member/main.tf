import {
  for_each = var.import_existing ? toset(var.roles) : toset([])
  to       = google_project_iam_member.bindings[each.value]
  id       = "${var.project_id} ${each.value} ${var.member}"
}

resource "google_project_iam_member" "bindings" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = var.member
}
