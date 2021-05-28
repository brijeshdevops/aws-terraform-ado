locals {
  s3_backend = "${var.project_name}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  tags = {
            Project    = "${var.project_name}"
  }
}

resource "aws_s3_bucket" "terraform_state" {

  count         = var.stagecount
  bucket        = format("${local.s3_backend}-%s", var.stages[count.index])
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

  tags = local.tags

}

resource "aws_s3_bucket_public_access_block" "terraform_state" {

  count                   = var.stagecount
  bucket                  = aws_s3_bucket.terraform_state[count.index].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "terraform_locks" {
  count        = var.stagecount
  depends_on   = [aws_s3_bucket.terraform_state]
  #name         = format("terraform_locks_%s", var.stages[count.index])
  name         = format("${local.s3_backend}_%s", var.stages[count.index])
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags

}




output "region" {
  value       = aws_s3_bucket.terraform_state[*].region
  description = "The name of the region : "
}

output "s3_buckets" {
  value       = aws_s3_bucket.terraform_state[*].bucket
  description = "The ARN of the S3 buckets : "
}

output "dynamodb_tables" {
  value       = aws_dynamodb_table.terraform_locks[*].name
  description = "The name of the DynamoDB tables : "
}