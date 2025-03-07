locals {
  # Ensure the base policy statements have a unique SID so Terraform
  # can merge all statements in `aws_iam_policy_document`.
  base_policy_default = jsondecode(data.databricks_aws_bucket_policy.this.json)
  base_policy_statements = [for i, stmt in local.base_policy_default.Statement :
    merge({ Sid = "Base-${i}" }, stmt)
  ]
  base_policy = jsonencode(merge(
    local.base_policy_default,
    { Statement = local.base_policy_statements },
  ))

  extra_policy_statements = jsonencode({ Statement = var.extra_policy_statements })
}

data "aws_caller_identity" "current" {}

data "databricks_aws_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.bucket
}

data "aws_iam_policy_document" "this" {
  source_policy_documents = [
    local.base_policy,
    local.extra_policy_statements,
  ]

  dynamic "statement" {
    for_each = var.logging.is_logging_dest ? [1] : []

    content {
      sid    = "Logging"
      effect = "Allow"
      actions = [
        "s3:PutObject",
      ]
      resources = [
        "${aws_s3_bucket.this.arn}/*",
      ]

      condition {
        test     = "ArnLike"
        variable = "aws:SourceArn"
        values   = var.logging.source_bucket_arns
      }

      condition {
        test     = "StringEquals"
        variable = "aws:SourceAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      principals {
        type        = "Service"
        identifiers = ["logging.s3.amazonaws.com"]
      }
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = var.name
  tags   = merge({ Name = var.name }, var.tags)
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket.this]
}

resource "aws_s3_bucket_policy" "this" {
  bucket     = aws_s3_bucket.this.id
  policy     = data.aws_iam_policy_document.this.json
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_versioning" "root_bucket_versioning" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Disabled"
  }
}

output "arn" {
  value = aws_s3_bucket.this.arn
}

output "name" {
  value = aws_s3_bucket.this.bucket
}
