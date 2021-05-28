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
    region         = var.region
    dynamodb_table = "learning-20210528233351-net"
    encrypt        = "true"
  }

}

provider "aws" {
  region = var.region
}

provider "null" {}
provider "external" {}

