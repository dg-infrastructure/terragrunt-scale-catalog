// Gruntwork Pipelines repository-wide configuration.
// Docs: https://docs.gruntwork.io/2.0/docs/pipelines/configuration/settings

repository {
  // Commits on this branch trigger `terragrunt apply`. PRs against it trigger `terragrunt plan`.
  // If you change this, also update the branch trigger in your CI workflow file.
  deploy_branch_name = "{{ .DeployBranch }}"

  // When true, Pipelines updates a single comment in-place on each push instead of creating a new one.
  // Docs: https://docs.gruntwork.io/2.0/reference/pipelines/configurations-as-code/api#consolidate_comments
  consolidate_comments = {{ .ConsolidateComments }}

  env {
    PIPELINES_FEATURE_EXPERIMENT_IGNORE_UNITS_WITHOUT_ENVIRONMENT = "true"
  }
}
