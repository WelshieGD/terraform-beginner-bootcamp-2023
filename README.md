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