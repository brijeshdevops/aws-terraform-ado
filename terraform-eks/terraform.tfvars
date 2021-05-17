# Project Config
project_id   = "java-app1"
env_type     = "test"
cloud_region = "us-east-1"

# EKS Config
eks_version              = "1.16"
eks_intance_type_main    = "t3.medium"
eks_cluster_main_ng_size = 2

# VPC Config
vpc_id = "vpc-03c8e6332bacf734d"

//vpc_cidr = "10.0.0.0/21"
//public_subnets  = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
//private_subnets = ["11.0.4.0/24", "11.0.5.0/24", "11.0.6.0/24"]
node_ssh_key    = "eks-9154"

