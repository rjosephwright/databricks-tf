variable "databricks_role_arn" {
  type = string
}

variable "external_id" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the IAM role."
}

variable "permissions_boundary_arn" {
  type = string

  default = null
}

variable "s3_resources" {
  type        = list(string)
  description = "A list of S3 resource patterns to grant access to."

  default = ["*"]
}

variable "tags" {
  type        = map(string)
  description = "Tags to attach to the IAM role."

  default = {}
}
