variable "project_id" {
  type        = string
  description = "Project ID"
  default     = "javaapp1"
}

variable "env_type" {
  type        = string
  description = "Type of Environment"
  default     = "dev"
}

variable "cloud_region" {
  type        = string
  description = "Region where resources will be created"
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID"
  default     = "vpc-03c8e6332bacf734d"
}

//variable "vpc_cidr" {
//  type        = string
//  description = "VPC CIDR"
//  default     = "10.0.0.0/21"
//}
//
//variable "public_subnets" {
//  type        = list(string)
//  description = "List of Public Subnets"
//}
//
//variable "private_subnets" {
//  type        = list(string)
//  description = "List of Private Subnets"
//}

variable "node_ssh_key" {
  type        = string
  description = "Name of existing SSK key for login to EC2/Nodes"
  default     = "eks-9154"
}

variable "eks_version" {
  type        = string
  description = "EKS Version Number"
  default     = "1.16"
}

variable "eks_intance_type_main" {
  type        = string
  description = "EKS Worker/Node Instance type"
  default     = "t3.small"
}

variable "eks_cluster_ng_max" {
  type        = number
  description = "EKS Cluster Node Groups Maximum size"
  default     = 3
}

variable "eks_cluster_ng_min" {
  type        = number
  description = "EKS Cluster Node Groups Minimum size"
  default     = 1
}

variable "eks_cluster_ng_desire" {
  type        = number
  description = "EKS Cluster Node Groups Desired size"
  default     = 2
}

variable "wait_for_cluster_cmd" {
  description = "Custom local-exec command to execute for determining if the eks cluster is healthy. Cluster endpoint will be available as an environment variable called ENDPOINT"
  type        = string
  default     = "until curl -k -s $ENDPOINT/healthz >/dev/null; do sleep 4; done"
}

variable "created_by" {
  type    = string
  default = "Brijesh Prajapati"
}

variable "purpose" {
  type    = string
  default = "EKS Java App Deployment"
}