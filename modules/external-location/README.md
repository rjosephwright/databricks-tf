# external-location

A Terraform module to manage a Databricks external location.

## Example

```
module "external_location" {
  source = "/path/to/modules/external-location"

  name = "abc"
  grants = [
    {
      principal   = "Data Engineers"
      permissions = ["ALL_PRIVILEGES"]
    }
  ]
  storage_credential = "default"
  s3_url             = "s3://abc-storage-xyz/"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| grants | A list of `grant` objects to configure on the catalog (see [below](#grant)). | `list(object)` | `[]` | no |
| name | The name of the external location. | `string` | N/A | yes |
| skip\_validation | Whether or not to skip validation when creating. | `bool` | `false` | no |
| storage\_credential | The name of the storage credential used for the external location. | `string` | N/A | yes |
| s3\_url | The S3 URL to be used for the storage location. | `string` | N/A | yes |

### grant

Each `grant` object contains the following structure.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| principal | The principal to be given permissions. | `string` | N/A | yes |
| privileges | A list of permissions to be given. | `list(string)` | N/A | yes |
