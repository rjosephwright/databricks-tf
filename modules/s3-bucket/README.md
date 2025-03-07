# s3-bucket

A Terraform module to configure an S3 bucket to use with Databricks.

## Example

```
module "s3_bucket" {
  source = "../../modules/s3-bucket"

  extra_policy_statements = var.root_bucket.extra_policy_statements
  name                    = "abc-xyz-databricks-root"
  tags                    = {
    org = "DE"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| extra\_policy\_statements | A list of additional policy statements to apply to the bucket policy. | `list(any)` | `[]` | no |
| name | The name of the bucket. | `string` | N/A | yes |
| tags | Tags to assign to the bucket. | `map(string)` | `{}` | no |
| logging | An object to configure the bucket for logging (see [below](#logging)). | `object` | `{}` | no |

### logging

The `logging` object contains the following structure.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| is\_logging\_dest | Whether or not the bucket is to be a logging destination. | `bool` | `false` | no |
| source\_bucket\_arns | A list of bucket ARNs that will log to this bucket. | `list(string)` | `[]` | no |
