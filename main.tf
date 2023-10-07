terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

terraform {
  cloud {
    organization = "TerraformBootcampGramski"

    workspaces {
      name = "terra-house-gd"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_shrewsbury_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.shrewsbury.public_path
  content_version = var.shrewsbury.content_version
}

resource "terratowns_home" "home" {
  name = "Shrewsbury"
  description = <<DESCRIPTION
Shrewsbury is a market town, civil parish and the county town of Shropshire, England, on the River Severn. The town is the birth place of Charles Darwin.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdq3gz.cloudfront.net"
  domain_name=module.home_shrewsbury_hosting.domain_name
  town = "missingo"
  content_version = var.shrewsbury.content_version
}

module "home_macbeth_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.macbeth.public_path
  content_version = var.macbeth.content_version
}

resource "terratowns_home" "home_macbeth" {
  name = "Another Day, another place in space and time"
  description = <<DESCRIPTION
Tomorrow and tomorrow and tomorrow creeps thy petty pace from day to day to the last syllable of recorded time.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdq3gz.cloudfront.net"
  domain_name = module.home_macbeth_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.macbeth.content_version
}





