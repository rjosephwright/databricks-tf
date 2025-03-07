terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.87.0, <6.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.66, < 2.0"
    }
  }
}
