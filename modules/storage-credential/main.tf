locals {
  grants = { for grant in var.grants : grant.principal => grant }
}

resource "databricks_storage_credential" "this" {
  name            = var.name
  skip_validation = var.skip_validation

  aws_iam_role {
    role_arn = var.iam_role_arn
  }
}

resource "databricks_grant" "them" {
  for_each = local.grants

  principal          = each.key
  privileges         = each.value.privileges
  storage_credential = databricks_storage_credential.this.id
}

output "storage_credential" {
  value = databricks_storage_credential.this
}
