variable "region" {
  description = "The name of the AWS Region"
  type        = string
  default     = "us-west-1"
}

variable "project_name" {
  description = "The name of the Project. Will be used as prefix and in tags."
  type        = string
  default     = "learning"
}

variable "created_by" {
  description = "Created By"
  type        = string
  default     = "'Brijesh Prajapati'"
}

variable "stages" {
  type    = list(string)
  default = ["net"]
}

variable "stagecount" {
  type    = number
  default = 1
}

