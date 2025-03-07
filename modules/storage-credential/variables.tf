variable "grants" {
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  description = "Grants to assign to the storage credential."

  default = []
}

variable "name" {
  type = string
}

variable "skip_validation" {
  type = bool

  default = false
}

variable "iam_role_arn" {
  type        = string
  description = "The ARN of the IAM role to use for the storage credential."
}
