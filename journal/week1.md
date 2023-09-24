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

# AWS
## S3 Buckets
- [Tagging Buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#example-usage)
```
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```

# Terraform
## Input Validation
- [Custom Input Validation](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules)


# Process
- terraform login(https://developer.hashicorp.com/terraform/cli/commands/login)
By default, Terraform will obtain an API token and save it in plain text in a local CLI configuration file called credentials.tfrc.json. 
- export TERRAFORM_CLOUD_TOKEN=""
- gp env TERRAFORM_CLOUD_TOKEN=""
    - If you need to delete an expired token then gp env -u TERRAFORM_CLOUD_TOKEN
    - You shouldn't need to re-create the credentials.tfc.json file.
    [file](https://developer.hashicorp.com/terraform/cli/commands/login#credentials-storage)
- terraform init
- terraform plan
    - Terraform Cloud will error with no value set for variable. You need to plan -var <<variable name>> and make sure it matches it constraints. 
        - 1a2b3c4d-1abc-7a8b-9c0d-1234567890ab (use chatapi to understand regex and then create a variable that meets the regex)
    - Terraform non-Cloud would prompt for variable value
- Make sure that the keys are activated in AWS
- Make sure AWS keys are valid in gitpod 
    - aws configure
    - aws sts get-caller-identity
    - check can list S3 buckets 
    ``` aws s3 ls


