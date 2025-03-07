# storage-credential

A Terraform module to manage a Databricks storage credential.

## Example

```
module "storage_credential" {
  source = "/path/to/modules/storage-credential"

  name = "abc"
  grants = [
    {
      principal   = "Data Engineers"
      permissions = ["ALL_PRIVILEGES"]
    }
  ]
  iam_role_arn = "arn:aws:iam::111122223333:role/abc"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| grants | A list of `grant` objects to configure on the catalog (see [below](#grant)). | `list(object)` | `[]` | no |
| name | The name of the external location. | `string` | N/A | yes |
| skip\_validation | Whether or not to skip validation when creating. | `bool` | `false` | no |
| iam\_role\_arn | The ARN of the IAM role to use for the storage credential. | `string` | N/A | yes |

### grant

Each `grant` object contains the following structure.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| principal | The principal to be given permissions. | `string` | N/A | yes |
| privileges | A list of permissions to be given. | `list(string)` | N/A | yes |
