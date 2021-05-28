terraform {
  required_version = "~> 0.15.3"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.39"
    }
    null = {
        source = "hashicorp/null"
        version = "~> 3.0"
    }
    external = {
        source = "hashicorp/external"
        version = "~> 2.0"
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "1.13.3"
    }

  }
}

provider "aws" {
  region                  = var.region
}

provider "null" {}
provider "external" {}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  required_version = "~> 0.15.3"
  required_providers {
      aws = {
         source = "hashicorp/aws"
         version = "3.39"
      }
      kubernetes = {
         source = "hashicorp/kubernetes"
         version = "1.13.3"
      }
  }
  backend "s3" {
      bucket = "tf-state-ip-10-0-0-12-1622225103086204764"
      key = "terraform/terraform_locks_net.tfstate"
      region = "us-east-1"
      dynamodb_table = "terraform_locks_net"
      encrypt = "true"
  }
}

resource "null_resource" "gen_backend" {
    triggers = {
        always_run = timestamp()
    }

    depends_on = [null_resource.sleep]

    provisioner "local-exec" {
        when = create
        command = "./gen-backend.sh"
    }
}


resource "null_resource" "sleep" {

    triggers = {
        always_run = timestamp()
    }

    depends_on = [aws_dynamodb_table.terraform_locks]

    provisioner "local-exec" {
        when = create
        command = "sleep 5"
    }
}

data "external" "bucket_name" {
  program = ["bash", "get-bucket-name.sh"]
}

output "Name" {
  value = data.external.bucket_name.result.Name
}

resource "aws_s3_bucket" "terraform_state" {

  bucket        = data.external.bucket_name.result.Name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    ignore_changes = [bucket]
  }

  tags = {
      Project      = var.cluster-name
  }

}

resource "aws_s3_bucket_public_access_block" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "terraform_locks" {

  count         = var.stagecount
  depends_on    = [aws_s3_bucket.terraform_state]
  name          = format("terraform_locks_%s",var.stages[count.index])
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}