resource "aws_iam_role_policy_attachment" "arn_policy_attachments_for_role" {
  role       = var.role_name
  policy_arn = var.policy_arn
}
