provider "aws" {
  region = var.aws_region
}

provider "databricks" {
  alias = "mws"

  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
}

provider "databricks" {
  alias = "workspace"

  host          = module.workspace.workspace_url
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
}
