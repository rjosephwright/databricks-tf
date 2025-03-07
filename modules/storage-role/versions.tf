terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.87.0, <6.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12, < 1.0"
    }
  }
}
