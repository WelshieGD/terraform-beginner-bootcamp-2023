# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project is going to use semantic versioning for its tagging.

Link - [semver.org](https://semver.org/)

The general format will be (do not include a v in front of  the version numbers):

**MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## References for CLI Refactor
### Considerations with Terraform CLI Changes
The terraform cli installation instructions have changed due to gpg keyring changes. So we need to refer to the lastest instauctions on the terraform website and change the original [.gitpod.yml](.gitpod.yml)

- [Installing the Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts

While fixing terraform deprecation we issues, we noticed the installation steps (bash script) had a lot more steps on the terraform documentation. So updated steps to align install with terraform best practice.

### Running new install file
The bash script is located at [/.bin/install_terraform_cli.sh](/bin/install_terraform_cli.sh)
- [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

File permissions needed updated to execute new file
- [Linux File Permissions](https://www.redhat.com/sysadmin/linux-file-permissions-explained)

- [chmod](https://en.wikipedia.org/wiki/Chmod)

- [GitPod init](https://www.gitpod.io/docs/configure/workspaces/tasks#prebuild-and-new-workspaces)
