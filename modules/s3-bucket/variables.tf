variable "extra_policy_statements" {
  type = list(any)

  default = []
}

variable "name" {
  type        = string
  description = "The name of the bucket."
}

variable "tags" {
  type        = map(string)
  description = "Tags to attach to the bucket."

  default = {}
}

variable "logging" {
  type = object({
    is_logging_dest    = optional(bool, false)
    source_bucket_arns = optional(list(string), [])
  })
  description = "An object to configure the bucket as a destination for S3 server access logging."

  default = {}
}
