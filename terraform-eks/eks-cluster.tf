data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}
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
data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../learn-terraform-provision-eks-cluster/terraform.tfstate"
  }
}

module "eks" {
  source                       = "terraform-aws-modules/eks/aws"
  cluster_name                 = local.cluster_name
  subnets                      = data.aws_subnet_ids.eks_subnets_private.ids  # data.aws_subnet_ids.eks_subnets.ids
  #subnets                      = module.vpc.private_subnets
  cluster_version              = var.eks_version
  vpc_id                       = var.vpc_id
  cluster_iam_role_name        = aws_iam_role.eks_service_role.name

//  manage_cluster_iam_resources = false

  worker_groups = [
   {
      name                          = "${local.cluster_name}-NG-1"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.main_security_group.id]
   }
  ]
  # windows workaround
  #wait_for_cluster_interpreter = ["C:/Users/bprajapati/Desktop/2019/TOOLs/cygwin64/bin/sh.exe","-c"]
  #wait_for_cluster_cmd = "until curl -sk $ENDPOINT >/dev/null; do sleep 4; done"
  #wait_for_cluster_cmd = "${var.wait_for_cluster_cmd}" # "until wget --no-check-certificate -O - -q $ENDPOINT/healthz >/dev/null; do sleep 4; done"

//
//  node_groups_defaults = {
//    ami_type  = "AL2_x86_64"
//    disk_size = 50
//  }
//
//  node_groups = {
//
//    node_group_one = {
//      //name             = "${local.cluster_name}-NG-app"
//      ami_type         = "AL2_x86_64"
//      disk_size        = 50
//      desired_capacity = var.eks_cluster_ng_desire
//      max_capacity     = var.eks_cluster_ng_max
//      min_capacity     = var.eks_cluster_ng_min
//      iam_role_arn     = aws_iam_role.eks_ng_role.arn
//      instance_type    = var.eks_intance_type_main
//      key_name         = var.node_ssh_key
//      source_security_group_ids = [
//        aws_security_group.main_security_group.id
//      ]
//
//      subnets = data.aws_subnet_ids.eks_subnets_private.ids
//
//      additional_tags = {
//          Name = "${local.cluster_name}-NG-app"
//          Created_by = var.created_by
//          Purpose    = var.purpose
//          Project    = var.project_id
//      }
//
//      k8s_labels = {
//          NodeGroupName = "${local.cluster_name}-NG-app"
//          lifecycle     = "app-nodes"
//          intent        = "java-app"
//      }
//    }
//
//  }

  tags = {
    Project    = var.project_id
    Created_By = var.created_by
    Purpose    = var.purpose
  }

  depends_on = [
    aws_iam_role.eks_service_role,
    aws_iam_role.eks_ng_role
  ]

}




# data.aws_vpc.selected_vpc.cidr_block_associations[0].cidr_block
data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "eks_subnets_public" {
  vpc_id = var.vpc_id
  tags = {
    type = "public"
  }
}

data "aws_subnet_ids" "eks_subnets_private" {
  vpc_id = var.vpc_id
  tags = {
    type = "private"
  }
}

data "aws_subnet_ids" "eks_subnets" {
  vpc_id = var.vpc_id
}





output "vpc_id" {
  description = "VPC ID : "
  value = var.vpc_id
}

output "vpc_id_cidr" {
  description = "VPC CIDR : "
  value = data.aws_vpc.selected_vpc.cidr_block_associations[0].cidr_block
}

output "vpc_all_subnets" {
  description = "Kubernetes VPC All Subnets : "
  value       = data.aws_subnet_ids.eks_subnets.ids
}

output "vpc_public_subnets" {
  description = "Kubernetes VPC Public Subnets : "
  value       = data.aws_subnet_ids.eks_subnets_public.ids
}

output "vpc_private_subnets" {
  description = "Kubernetes VPC Private Subnets : "
  value       = data.aws_subnet_ids.eks_subnets_private.ids
}

output "cluster_name" {
  description = "Kubernetes Cluster Name : "
  value       = local.cluster_name
}

output "cluster_id" {
  description = "Kubernetes Cluster ID : "
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane : "
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane : "
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "region" {
  description = "AWS region"
  value       = var.region
}