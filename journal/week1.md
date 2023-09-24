# Week 1 Bootcamp ReadMe

## Terraform Root Module Structure

Our root modules structure is as follows:

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

```
PROJECT_ROOT
|
|-- main.tf - everything else
|-- variables.tf - stores the structure of the input variables
|-- outputs.tf - stores our outputs
|-- providers.tf - defined providers and their configuration
|-- terraform.tfvars - the data of the variables we want to load into our terraform project
|-- README.md - required for root modules
