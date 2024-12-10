provider "hcp" {
  project_id = var.HCP_PROJECT_ID
}

provider "vault" {
  address = hcp_vault_cluster.vault_demo.vault_public_endpoint_url
  token   = hcp_vault_cluster_admin_token.vault_admin_token.token
}

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

provider "azurerm" {
  features {}

  client_id       = var.AZURE_CLIENT_ID
  client_secret   = var.AZURE_CLIENT_SECRET
  tenant_id       = var.AZURE_TENANT_ID
  subscription_id = var.AZURE_SUBSCRIPTION_ID
}