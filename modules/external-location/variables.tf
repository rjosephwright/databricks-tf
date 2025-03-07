variable "grants" {
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  description = "Grants to assign to the external location."

  default = []
}

variable "name" {
  type = string
}

variable "skip_validation" {
  type = bool

  default = false
}

variable "storage_credential" {
  type        = string
  description = "The name of the storage credential to use for the external location."
}

variable "s3_url" {
  type = string
}
