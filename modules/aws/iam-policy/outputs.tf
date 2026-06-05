output "arn" {
  description = "The ARN of the policy."
  value       = aws_iam_policy.policy.arn
}

output "name" {
  description = "The name of the policy, including the content hash suffix."
  value       = aws_iam_policy.policy.name
}
