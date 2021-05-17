//provider "aws" {
//  version = ">=2.0"
//  region  = "us-east-1"
//  //shared_credentials_file = "C:/Users/bprajapati/.aws/credentials"
//  //profile                 = "opencloud"
//}

// Disabled for Azure ADO
//terraform {
//  backend "s3" {
//    bucket         = "cf-templates-1n70pnlozst11-us-east-1"
//    key            = "terraform.tfstate"
//    dynamodb_table = "terraform_lock"
//    region         = "us-east-1"
//    //shared_credentials_file = "C:/Users/bprajapati/.aws/credentials"
//    //profile                 = "opencloud"
//  }
//}


terraform {

  required_version = ">= 0.13"

  required_providers {

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
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
////  token                  = data.aws_eks_cluster_auth.cluster.token
////  load_config_file       = false
//}

// This is for Terraform 0.12
//provider "kubectl" {
//  apply_retry_count      = 15
//  host                   =              data.aws_eks_cluster.cluster.endpoint
//  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
//  load_config_file       = false
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
