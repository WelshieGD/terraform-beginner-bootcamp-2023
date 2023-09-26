output "bucket_name" {
  description = "Bucket Name"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website Host Endpoint"
  value = module.terrahouse_aws.website_endpoint 
}