# GCP Service Account IAM Binding

This module grants an external identity (from Workload Identity Federation) the ability to impersonate a Google Cloud service account.

## Usage

### For GitHub Actions - Repository-wide access (Plan)

```hcl
module "plan_workload_identity_binding" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/service-account-iam-binding?ref=v1.0.0"

  service_account_id = "projects/my-project/serviceAccounts/pipelines-plan@my-project.iam.gserviceaccount.com"

  # Allow any workflow from the repository to impersonate this service account
  member = "principalSet://iam.googleapis.com/projects/123456789/locations/global/workloadIdentityPools/github-pool/attribute.repository/my-org/my-repo"
}
```

### For GitHub Actions - Branch-specific access (Apply)

```hcl
module "apply_workload_identity_binding" {
  source = "github.com/gruntwork-io/terragrunt-scale-catalog//modules/gcp/service-account-iam-binding?ref=v1.0.0"

  service_account_id = "projects/my-project/serviceAccounts/pipelines-apply@my-project.iam.gserviceaccount.com"

  # Only allow the main branch to impersonate this service account
  member = "principal://iam.googleapis.com/projects/123456789/locations/global/workloadIdentityPools/github-pool/subject/repo:my-org/my-repo:ref:refs/heads/main"
}
```

## Workload Identity Member Formats

| Format | Description | Use Case |
|--------|-------------|----------|
| `principalSet://...workloadIdentityPools/{pool}/attribute.repository/{org}/{repo}` | Any identity with matching repository | Plan operations (any branch/PR) |
| `principal://...workloadIdentityPools/{pool}/subject/{subject}` | Specific subject claim | Apply operations (specific branch) |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `service_account_id` | The fully-qualified ID of the service account | `string` | Yes |
| `member` | The IAM member (principalSet:// or principal://) | `string` | Yes |

## Outputs

This module does not produce outputs.
