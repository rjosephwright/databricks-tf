terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.66, < 2.0"
    }
  }
}
