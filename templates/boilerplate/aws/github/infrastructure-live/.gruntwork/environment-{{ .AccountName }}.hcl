environment "{{ .AccountName }}" {
  filter {
    paths = ["{{ .AccountName }}/*"]
  }

  authentication {
    aws_oidc {
      account_id         = "{{ .AWSAccountID }}"
      plan_iam_role_arn  = "arn:aws:iam::{{ .AWSAccountID }}:role/{{ .OIDCResourcePrefix }}-plan"
      apply_iam_role_arn = "arn:aws:iam::{{ .AWSAccountID }}:role/{{ .OIDCResourcePrefix }}-apply"
    }
  }
}
