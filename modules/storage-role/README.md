# storage-role

A Terraform module to configure an AWS IAM role to use for storage.

## Example

```
module "storage_role" {
  source = "/path/to/modules/storage-role"

  databricks_role_arn = "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
  external_id         = "626a3e57-51f6-4b5e-ab8b-e97a898cdd70"
  name                = "abc-workspace-catalog"
  s3_resources = [
    "arn:aws:s3:::abc-workspace-catalog",
    "arn:aws:s3:::abc-workspace-catalog/*",
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| databricks\_role\_arn | The Databricks [Unity Catalog IAM role](https://docs.databricks.com/aws/en/connect/unity-catalog/cloud-storage/storage-credentials#step-1-create-an-iam-role) that will assume this role. | `string` | N/A | yes |
| external\_id | The external ID passed by Databricks when assuming the role. Use your Databricks account ID. | `string` | N/A | yes |
| name | The name of the IAM role. | `string` | N/A | yes |
| permissions\_boundary\_arn | The ARN of an IAM policy used for a permissions boundary. | `string` | `null` | no |
| s3\_resources | A list of S3 ARN patterns that the role will be given access to. | `list(string)` | `["*"]` | no |
| tags | Tags to assign to AWS resources. | `map(string)` | `{}` | no |
