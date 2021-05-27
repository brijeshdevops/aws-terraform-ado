# TF_VAR_region
variable "region" {
  description = "The name of the AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "cluster-name" {
  description = "The name of the EKS Cluster"
  type        = string
  default     = "mycluster1"
}
