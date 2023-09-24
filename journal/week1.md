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
        - terraform plan -var user_uuid="1a2b3c4d-5e6f-7abc-9abc-1234567890ab"
        - You can also store this as a Terraform Cloud variable. 
    - Terraform non-Cloud would prompt for variable value
- Make sure that the keys are activated in AWS
- Make sure AWS keys are valid in gitpod 
    - aws configure
    - aws sts get-caller-identity
    - check can list S3 buckets 
    ``` 
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    AWS_DEFAULT_REGION

    aws s3 ls
    ```
- If you need to delete keys then:
```
env | grep AWS

unset <<Variable>>

```

- Make sure that Terraform Cloud has variables set - https://app.terraform.io/app/TerraformBootcampGramski/workspaces/terra-house-gd/variables 
-- WorkSpace Variables \ environment variables \  Sensitive


# Other Terraform Links
## Terraform import
[Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

```
terraform import aws_s3_bucket.bucket bucket-name
# .bucket is the name in Terraform, not the AWS Bucket Name e.g.
# terraform import aws_s3_bucket.example terraform 5p0vda6gtp33nq0fjublyalt56s7ylih

```
Or 
```
import {
  to = aws_s3_bucket.bucket
  id = "bucket-name"
}
```

## Terraform Plan - Destroy and recreate bucket
This will show that Terraform plans to destroy and recreate the bucket rather than import the existing bucket

The following error is a latency error. Re-run apply
Error: creating Amazon S3 (Simple Storage) Bucket (5p0vda6gtp33nq0fjublyalt56s7ylih): BucketAlreadyOwnedByYou: Your previous request to create the named bucket succeeded and you already own it.