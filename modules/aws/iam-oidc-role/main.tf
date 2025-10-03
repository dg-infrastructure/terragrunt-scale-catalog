resource "aws_iam_role" "role" {
  name = var.name
  path = var.path

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRoleWithWebIdentity"

        Principal = {
          Federated = var.oidc_provider_arn
        }

        Condition = {
          (var.condition_operator) = {
            (var.sub_key) = var.sub_value
          }
        }
      }
    ]
  })

  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary

  tags = var.tags
}
