locals {
  external_locations = { for location in var.external_locations : location.name => location }
  s3_resources = flatten([for bucket in module.s3_bucket : [
    bucket.arn,
    "${bucket.arn}/*",
  ]])
}

module "s3_bucket" {
  source   = "../modules/s3-bucket"
  for_each = local.external_locations

  name = each.value.bucket_name
}

module "storage_role" {
  source = "../modules/storage-role"
  count  = length(local.external_locations) > 0 ? 1 : 0

  databricks_role_arn      = var.databricks_role_arn
  external_id              = var.databricks_account_id
  name                     = var.storage_iam_role_name
  permissions_boundary_arn = var.permissions_boundary_arn
  s3_resources             = local.s3_resources
}

module "storage_credential" {
  source = "../modules/storage-credential"
  count  = length(local.external_locations) > 0 ? 1 : 0

  iam_role_arn    = one(module.storage_role[*].iam_role_arn)
  name            = var.storage_credential.name
  skip_validation = false

  depends_on = [module.bucket_catalogs]
}

module "external_location" {
  source   = "../modules/external-location"
  for_each = local.external_locations

  name               = each.key
  s3_url             = "s3://${each.value.bucket_name}/"
  skip_validation    = false
  storage_credential = one(module.storage_credential[*].storage_credential.name)

  depends_on = [
    module.storage_credential,
  ]
}
