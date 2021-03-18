//variable "projectName" {
//  type        = string
//  description = "Project ID"
//}
//
//variable "envType" {
//  type        = string
//  description = "Type of Environment"
//}

//
//
//variable "cloud_region" {
//  type        = string
//  description = "Region where resources will be created"
//}
//
//variable "vpc_cidr" {
//  type        = string
//  description = "VPC CIDR"
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
//
//variable "node_ssh_key" {
//  type        = string
//  description = "Name of existing SSK key for login to EC2/Nodes"
//}
//
//variable "eks_version" {
//  type        = string
//  description = "EKS Version Number"
//}
//
//variable "eks_intance_type_main" {
//  type        = string
//  description = "EKS Worker/Node Instance type"
//}
//
//variable "eks_cluster_main_ng_size" {
//  type        = number
//  description = "EKS Cluster Main Worker/Node Groups size"
//}
//
//variable "wait_for_cluster_cmd" {
//  description = "Custom local-exec command to execute for determining if the eks cluster is healthy. Cluster endpoint will be available as an environment variable called ENDPOINT"
//  type        = string
//  default     = "until curl -k -s $ENDPOINT/healthz >/dev/null; do sleep 4; done"
//}
