// Pipelines environment config for the auth-less "{{ .AccountName }}" tutorial environment.
// Pipelines reads all .hcl files in .gruntwork/. This environment intentionally has NO cloud
// authentication: units under it (a self-contained null_resource tutorial unit with local state)
// plan/apply with no cloud credentials. The real cloud OIDC config is added later by the
// "Connect to your cloud" wizard (the cloud-config template) once the customer authorizes their cloud.
// Docs: https://docs.gruntwork.io/2.0/docs/pipelines/configuration/settings

environment "{{ .AccountName }}" {
  // Matches all units under {{ .AccountName }}/.
  filter {
    paths = ["{{ .AccountName }}/*"]
  }

  // Empty authentication: no cloud provider configured yet, so Pipelines runs plan/apply without
  // assuming any role. Valid HCL — parses to a zero-value Authentication struct.
  authentication {}
}
