# Terragrunt Scale Catalog

This is a catalog of free, open-source Infrastructure as Code (IaC) configurations for setting up [Terragrunt Scale](https://terragrunt.gruntwork.io/terragrunt-scale/) customers.

## Overview

The Terragrunt Scale Catalog provides pre-built, production-ready infrastructure components for bootstrapping CI/CD pipelines with OIDC authentication. It supports both AWS and Azure cloud providers, with integrations for GitHub and GitLab.

## Repository Structure

This repository is organized into three main components:

### Modules (`modules/`)

Reusable OpenTofu modules that define cloud resources. These are the building blocks referenced by units.

- **`modules/aws/`** - AWS-specific OpenTofu modules
  - `iam-oidc-role` - IAM role with OIDC trust policy
  - `iam-openid-connect-provider` - IAM OIDC provider
  - `iam-policy` - IAM policy documents
  - `iam-role-policy-attachment` - Attach policies to IAM roles

- **`modules/azure/`** - Azure-specific OpenTofu modules
  - `entra-id-application` - Entra ID (Azure AD) application
  - `entra-id-service-principal` - Service principal for applications
  - `entra-id-federated-identity-credential` - Federated identity credential (static subject)
  - `entra-id-flexible-federated-identity-credential` - Flexible federated identity credential (with claim matching expressions)
  - `entra-id-role-assignment` - Role assignment to a specific scope
  - `entra-id-role-assignment-to-sub` - Role assignment at subscription level
  - `resource-group` - Azure resource group
  - `storage-account` - Azure storage account
  - `storage-container` - Azure storage container

### Units (`units/`)

Terragrunt unit configurations that wrap modules with specific configurations and dependencies. Units represent deployable infrastructure components.

- **`units/aws/oidc/`** - AWS OIDC configuration units
  - `iam-oidc-role` - Configured IAM OIDC role
  - `iam-openid-connect-provider` - Configured OIDC provider
  - `iam-policy` - Configured IAM policy
  - `iam-role-policy-attachment` - Configured policy attachment

- **`units/azure/state/`** - Azure state management units
  - `resource-group` - Resource group for state storage
  - `storage-account` - Storage account for OpenTofu state
  - `storage-container` - Container for state files

- **`units/azure/oidc/`** - Azure OIDC configuration units
  - `entra-id-application` - Configured Entra ID application
  - `entra-id-service-principal` - Configured service principal
  - `entra-id-federated-identity-credential` - Configured federated identity (static)
  - `entra-id-flexible-federated-identity-credential` - Configured flexible federated identity
  - `service-principal-to-scope-role-assignment` - Role assignment to a specific scope
  - `service-principal-to-sub-role-assignment` - Role assignment at subscription level

### Stacks (`stacks/`)

Terragrunt stack configurations that compose multiple units into complete infrastructure setups. Stacks represent end-to-end solutions.

- **`stacks/aws/github/pipelines-bootstrap/`** - Bootstrap AWS resources for Gruntwork Pipelines (GitHub Actions) with OIDC
- **`stacks/aws/gitlab/pipelines-bootstrap/`** - Bootstrap AWS resources for Gruntwork Pipelines (GitLab CI) with OIDC
- **`stacks/azure/github/pipelines-bootstrap/`** - Bootstrap Azure resources for Gruntwork Pipelines (GitHub Actions) with OIDC

## Documentation

Detailed documentation for each component can be found in their respective directories:

- [Modules Documentation](modules/)
- [Units Documentation](units/)
- [Stacks Documentation](stacks/)

## Use Cases

### Bootstrap Gruntwork Pipelines

Regardless of whether you're using GitHub Actions, GitLab CI, AWS or Azure (GitHub Actions only here, at the moment), you can bootstrap Gruntwork Pipelines by following the documentation in the official [Gruntwork Pipelines setup docs](https://docs.gruntwork.io/2.0/docs/pipelines/installation/addingnewrepo).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

See [LICENSE](LICENSE) for full details.
