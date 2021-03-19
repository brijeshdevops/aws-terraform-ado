variable "region" {
  type = string
  description = "AWS Region"
  default = "us-east-2"
}

locals {
  common_prefix = "${var.projec_name}-${var.env_type}"
  elk_domain = "${local.common_prefix}"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}


provider "aws" {
  version = ">=2.0"
  region  = var.region
  //shared_credentials_file = "C:/Users/bprajapati/.aws/credentials"
  //profile                 = "ana"
}

terraform {
  backend "s3" {
    bucket         = "tstatebucket01ohio"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform_lock"   # Partition Key LockID
    region         = var.region
    //shared_credentials_file = "C:/Users/bprajapati/.aws/credentials"
    //profile                 = "ana"
  }
}
