locals {
  grants = { for grant in var.grants : grant.principal => grant }
}

data "databricks_storage_credential" "this" {
  name = var.storage_credential
}

resource "databricks_external_location" "this" {
  credential_name = data.databricks_storage_credential.this.name
  name            = var.name
  skip_validation = var.skip_validation
  url             = var.s3_url
}

resource "databricks_grant" "external_location" {
  for_each = local.grants

  external_location = databricks_external_location.this.id
  principal         = each.key
  privileges        = each.value.privileges
}

output "external_location" {
  value = databricks_external_location.this
}
