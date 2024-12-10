$terraformOutput = terraform output -json

$outputObjects = $terraformOutput | ConvertFrom-Json

[Environment]::SetEnvironmentVariable("VAULT_ADDR",$outputObjects.vault_cluster_uri.value,"User")
[Environment]::SetEnvironmentVariable("VAULT_TOKEN",$outputObjects.vault_admin_token.value,"User")
[Environment]::SetEnvironmentVariable("VAULT_NAMESPACE","admin","User")

[Environment]::SetEnvironmentVariable("AWS_ACCESS_KEY_ID",$outputObjects.aws_demo_user_key_id.value,"User")
[Environment]::SetEnvironmentVariable("AWS_SECRET_ACCESS_KEY",$outputObjects.aws_demo_user_key.value,"User")

[Environment]::SetEnvironmentVariable("AZR_KEYVAULT_URI",$outputObjects.azure_kv_uri.value,"User")
[Environment]::SetEnvironmentVariable("AZR_CLIENT_ID",$outputObjects.azure_client_id.value,"User")
[Environment]::SetEnvironmentVariable("AZR_CLIENT_SECRET",$outputObjects.azure_client_secret.value,"User")
[Environment]::SetEnvironmentVariable("AZR_TENANT_ID",$outputObjects.azure_tenant_id.value,"User")