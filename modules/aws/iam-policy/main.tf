locals {
  policy_name = "${var.name}-${substr(sha256(var.policy), 0, 8)}"
}

resource "aws_iam_policy" "policy" {
  name        = local.policy_name
  path        = var.path
  description = var.description

  policy = var.policy

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}
