output "vault_cluster_uri" {
  value = hcp_vault_cluster.vault_demo.vault_public_endpoint_url
}

output "vault_admin_token" {
  value     = hcp_vault_cluster_admin_token.vault_admin_token.token
  sensitive = true
}

output "aws_demo_user_key_id" {
  value     = aws_iam_access_key.usr_ss_demo.id
  sensitive = true
}

output "aws_demo_user_key" {
  value     = aws_iam_access_key.usr_ss_demo.secret
  sensitive = true
}

output "azure_kv_uri" {
  value = azurerm_key_vault.kv_ss_demo.vault_uri
}

output "azure_client_id" {
  value     = var.AZURE_CLIENT_ID
  sensitive = true
}

output "azure_client_secret" {
  value     = var.AZURE_CLIENT_SECRET
  sensitive = true
}

output "azure_tenant_id" {
  value     = var.AZURE_TENANT_ID
  sensitive = true
}

output "github_access_token" {
  value     = var.GITHUB_ACCESS_TOKEN
  sensitive = true
}

output "github_owner_name" {
  value     = var.GITHUB_OWNER_NAME
  sensitive = false
}

output "github_repo_name" {
  value     = var.GITHUB_REPO_NAME
  sensitive = false
}