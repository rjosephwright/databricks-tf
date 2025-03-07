data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id

  aws_account_root = "arn:aws:iam::${local.aws_account_id}:root"

  this_role = "arn:aws:iam::${local.aws_account_id}:role/${var.name}"
}

resource "aws_iam_policy" "this" {
  name = "${var.name}-access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
        ]
        Resource = var.s3_resources
        Effect   = "Allow"
      },
      {
        Action = [
          "sts:AssumeRole",
        ]
        Resource = [
          local.this_role,
        ]
        Effect = "Allow"
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_role" "this" {
  name = var.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            var.databricks_role_arn,
          ]
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.external_id
          }
        }
      },
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            local.aws_account_root,
          ]
        }
        Action = "sts:AssumeRole"
        Condition = {
          ArnEquals = {
            "aws:PrincipalArn" = local.this_role
          }
          StringEquals = {
            "sts:ExternalId" = var.external_id
          }
        }
      },
    ]
  })
  permissions_boundary = var.permissions_boundary_arn
  tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}

resource "time_sleep" "this" {
  create_duration = "10s"

  depends_on = [aws_iam_role_policy_attachment.this]
}

output "iam_role_arn" {
  value = aws_iam_role.this.arn

  depends_on = [time_sleep.this]
}
