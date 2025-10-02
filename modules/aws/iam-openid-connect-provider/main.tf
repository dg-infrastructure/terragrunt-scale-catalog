resource "aws_iam_openid_connect_provider" "identity_provider" {
  url            = var.url
  client_id_list = var.client_id_list

  tags = var.tags
}
