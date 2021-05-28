variable "project_name" {
  type        = string
  description = "Project ID"
  default     = "learning"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "13.0.0.0/21"
}

variable "node_ssh_key" {
  type        = string
  description = "Name of existing SSK key for login to EC2/Nodes"
  default     = "default-ec2-key"
}

variable "stages" {
  type=list(string)
  default=["net"]
}

variable "stagecount" {
  type=number
  default=1
}
