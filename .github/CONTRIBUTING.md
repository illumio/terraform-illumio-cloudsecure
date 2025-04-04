# Contributing Guide

## GitHub Workflow

Non-Illumio contributors to the project should follow this workflow:

1. Fork the repo
2. Create a new branch on the fork
3. Push the branch to your fork
4. Submit a pull request following [GitHub's standard process](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)

## Bug Reporting

> [!CAUTION]
> If you find a bug or issue that you believe to be a security vulnerability, please see the [SECURITY](SECURITY.md) document for instructions on reporting. **Do not file a public GitHub Issue.**

Please report any bugs you find as GitHub issues.

Before reporting any bugs, please do a quick search to see if it has already been reported. If so, please add a comment on the existing issue rather than creating a new one.

While reporting a bug, please provide a minimal example to reproduce the issue. Include `.tf` files, **making sure to remove any secrets**. If applicable, include the `crash.log` file as well.

## Documentation

When submitting a new nested module, please follow the [standard module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure) and especially add examples and documentation. When making changes to existing nested modules, update the corresponding example and documentation.

## Release Checklist

1. Choose a version number for the new release. Follow [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html) format `vX.Y.Z`, e.g. `v1.2.3`.
1. Update the version of the module in the documentation and examples, and eventually the versions of dependencies (e.g. the `cloud-operator` Helm chart or the [`terraform-provider-illumio-cloudsecure` Terraform provider](https://github.com/illumio/terraform-provider-illumio-cloudsecure)). You may use the `./version_updating.sh` shell script to replace versions across the whole repo. For example, to replace  version v1.0.4 to v1.0.5, run `./version_updating.sh . "1.0.4" "1.0.5"`. In the PR, make sure that the documentation is regenerated by the `Generate terraform docs` GitHub Action.
1. Create a [new GitHub release](https://github.com/illumio/terraform-illumio-cloudsecure) with a new git tag named after the `vX.Y.Z` version, e.g. `v1.2.3`. Summarize the changes in this release.
   1. Click `Generate release notes` to generate the `What's Changed` section.
   1. Edit the generated `What's Changed` section to follow the [Changelog Specification](https://developer.hashicorp.com/terraform/plugin/best-practices/versioning#changelog-specification), esp. to follow the same [categories](https://developer.hashicorp.com/terraform/plugin/best-practices/versioning#categorization) for subsections. Link to the PR(s) for each item. For example:

      ```
      ## What's Changed
      
      ### BREAKING CHANGES:

      * modules/aws_account: Remove required `description` variable #12
      ### FEATURES:

      * **New Module:** `modules/azure_account` #14
      ### BUG FIXES:
      
      * module/k8s_cluster: Fix handling of incorrect `namespace` variable value #24
      ```
2. Verify that the [HashiCorp Terraform Registry](https://registry.terraform.io/modules/illumio/cloudsecure/illumio/latest) publishes the new release.
