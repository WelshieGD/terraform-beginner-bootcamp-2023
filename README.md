# Terraform Beginner Bootcamp 2023 - week 0

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


### Working with Env Vars
We can list out all environment variables (Env Vars) using the `env` command

We can filter specific environment variables using group. E.g. `env | grep AWS_`

### Setting and unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset usin `unset HELLO` (no need for$)

We can set an env var temporarily when just running a command 
```sh
$HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export. E.g.

```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```
### Printing Env Vars

We can print an env vcar using echo. ER.g. `echo $HELLO`

### Scope

When you open up a new bash terminal in VS Code, it will not be aware of env vars that you set in another window. 

If you want to env vars to persist across all future bash terminals that are open you need to env vars in your bash prfile e.g. `.bash_profile`

### Persisting env vars in Gitpod
Use gitpods secret storage


## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started with the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) 


## AWS Env Vars
We can check if our AWS Credentials are set correctly by running the following command
```sh
aws sts get-caller-identity
```

En Vars listed:

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

## Terraform Basics

### Terraform Registry
Providers and Modules - [link](https://registry.terraform.io/)

**Providers** = way you directly interact with API
	- Aws
	- Azure
	- GCP
	- K8s

**Modules** Collection of Terraform files \ template to commonly used functions

### Terraform init
(https://developer.hashicorp.com/terraform/cli/commands/init)

### Terraform plan
(https://developer.hashicorp.com/terraform/cli/commands/plan)

### Terraform apply
(https://developer.hashicorp.com/terraform/cli/commands/apply)

### Terraform lock files
This file should be committed to source code
(https://developer.hashicorp.com/terraform/language/files/dependency-lock)

### Terraform State Files
These files should not be committed to source code
(https://spacelift.io/blog/terraform-state)

### Terraform init, plan and apply
