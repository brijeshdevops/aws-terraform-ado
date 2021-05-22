
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.cloud_region
}

provider "local" {
  version = "~> 1.2"
}


//provider "aws" {
//  region = "us-east-1"
//  //shared_credentials_file = "C:/Users/bprajapati/.aws/credentials"
//  //profile                 = "opencloud"
//}

terraform {
  backend "s3" {
    bucket         = "innovalab-working-bucket"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform_lock"
    region         = "us-east-1"
    //shared_credentials_file = "C:/Users/bprajapati/.aws/credentials"
    //profile                 = "opencloud"
  }
}

locals {
  cluster_name = "${var.project_id}-${var.env_type}-EKS-Cluster"
}

provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, [""]), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, [""]), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, [""]), 0)
  load_config_file       = false
  version                = "1.10"
}

//provider "kubernetes" {
//  host                   = data.aws_eks_cluster.cluster.endpoint
//  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
//
//  # Required in >= 0.13
//  exec {
//    api_version = "client.authentication.k8s.io/v1alpha1"
//    args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
//    command     = "aws"
//  }
//
//  # Required in v 0.12
//  //  token                  = data.aws_eks_cluster_auth.cluster.token
//  //  load_config_file       = false
//}

// This is for Terraform 0.12
//provider "kubectl" {
//  apply_retry_count      = 15
//  host                   =              data.aws_eks_cluster.cluster.endpoint
//  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
////  load_config_file       = false
//
//  exec {
//    api_version = "client.authentication.k8s.io/v1alpha1"
//    command     = "aws-iam-authenticator"
//    args = [
//      "token",
//      "-i",
//      local.cluster_id,
//    ]
//  }
//}
