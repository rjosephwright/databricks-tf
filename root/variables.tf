variable "aws_region" {
  type        = string
  description = "The AWS region."
}

variable "databricks_role_arn" {
  type = string

  default = "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
}

variable "databricks_account_id" {
  type        = string
  description = "The ID of the Databricks account."
}

variable "databricks_client_id" {
  type        = string
  description = "The ID of the Databricks client for authentication."
}

variable "databricks_client_secret" {
  type        = string
  description = "The secret of the Databricks client for authentication."
  sensitive   = true
}

variable "external_locations" {
  type = list(object({
    name        = string
    bucket_name = string
  }))
  description = "A list of external locations to create."

  default = []
}

variable "permissions_boundary_arn" {
  type        = string
  description = "The ARN of an IAM policy to use as a permissions boundary."

  default = null
}

variable "storage_credential" {
  type = object({
    name = string
    grants = optional(list(object({
      principal  = string
      privileges = list(string)
    })), [])
  })
  description = "An object to configure the storage credential."
}

variable "storage_iam_role_name" {
  type        = string
  description = "The name of the IAM role to use for the storage credential."
  default     = "databricks-storage-catalog"
}
