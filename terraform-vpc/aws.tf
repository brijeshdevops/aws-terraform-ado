terraform {

  required_version = "~> 0.15.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.39"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.3"
    }
  }

  backend "s3" {
    bucket         = "learning-20210528233351-net"
    key            = "terraform/terraform_locks.tfstate"
    region         = "us-west-1"
    dynamodb_table = "learning-20210528233351-net"
    encrypt        = "true"
  }

}

provider "aws" {
  region = var.region
}

provider "null" {}
provider "external" {}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  prefix = "${var.project_name}"
  tags   = {
                Project    = "${var.project_name}",
                Owner      = "${var.created_by}"
           }
}