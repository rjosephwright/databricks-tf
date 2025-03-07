
Create a tfvars file `vars.tfvars`:

```
aws_region            = "us-east-1"
databricks_account_id = "0b2f6733-537d-4370-8557-1fa411222b65"

# ID of service principal
databricks_client_id = "4d8a8220-f19e-492e-bfc9-0a3a516a6680"

# Should set on the command line with TF_VAR_databricks_client_secret=XXXXXX
# databricks_client_secret = "XXXXXX"

external_locations = [
  {
    name        = "abc"
    bucket_name = "databricks-storage-abc"
  },
  {
    name        = "xyz"
    bucket_name = "databricks-storage-xyz"
  },
]

storage_credential    = "acme-storage-default"
storage_iam_role_name = "acme-storage-default"
```

```
terraform apply -var-file=vars.tfvars
```
