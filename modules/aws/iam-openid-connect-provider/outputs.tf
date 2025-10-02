output "arn" {
  description = "The ARN of the identity provider."
  value       = aws_iam_openid_connect_provider.identity_provider.arn
}
