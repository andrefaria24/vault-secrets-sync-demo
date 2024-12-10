resource "hcp_hvn" "hvn_demo" {
  hvn_id         = var.HCP_HVN_ID
  cloud_provider = var.HCP_CLOUD_PROVIDER
  region         = var.HCP_HVN_REGION
  cidr_block     = var.HCP_HVN_CIDR
}

resource "hcp_vault_cluster" "vault_demo" {
  cluster_id      = var.VAULT_CLUSTER_ID
  hvn_id          = hcp_hvn.hvn_demo.hvn_id
  tier            = var.VAULT_CLUSTER_TIER
  proxy_endpoint  = var.VAULT_CLUSTER_PROXY_ENDPOINT
  public_endpoint = var.VAULT_CLUSTER_PUBLIC_ENDPOINT

  lifecycle {
    prevent_destroy = false
  }
}

resource "hcp_vault_cluster_admin_token" "vault_admin_token" {
  cluster_id = hcp_vault_cluster.vault_demo.cluster_id
}

resource "aws_iam_user" "usr_ss_demo" {
  name = "ss-demo"

  tags = {
    tag-key = "vault secrets sync demo"
  }
}

resource "vault_mount" "kvv2" {
  path    = "kvv2"
  type    = "kv"
  options = { version = "2" }
}

resource "vault_kv_secret_v2" "kv_secret" {
  mount               = vault_mount.kvv2.path
  name                = "database/dev"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      api_key = "foo",
      key_id  = "123456789"
    }
  )
}

resource "aws_iam_access_key" "usr_ss_demo" {
  user = aws_iam_user.usr_ss_demo.name
}

data "aws_iam_policy_document" "pol_secrets_syncing" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:*:*:secret:vault*"]

    actions = [
      "secretsmanager:Create*",
      "secretsmanager:Update*",
      "secretsmanager:Delete*",
      "secretsmanager:TagResource",
    ]
  }
}

resource "aws_iam_user_policy" "usr_ss_demo" {
  name   = "secrets_syncing"
  user   = aws_iam_user.usr_ss_demo.name
  policy = data.aws_iam_policy_document.pol_secrets_syncing.json
}

resource "azurerm_resource_group" "rg_ss_demo" {
  name     = "rg-ss-demo"
  location = var.AZURE_REGION
}

resource "random_string" "kv_ss_demo_str" {
  length  = 6
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_key_vault" "kv_ss_demo" {
  name                       = "kv-ss-demo-${random_string.kv_ss_demo_str.result}"
  location                   = var.AZURE_REGION
  resource_group_name        = azurerm_resource_group.rg_ss_demo.name
  tenant_id                  = var.AZURE_TENANT_ID
  sku_name                   = var.AZURE_KEYVAULT_SKU
  soft_delete_retention_days = 7
  #enable_rbac_authorization = true

  access_policy {
    tenant_id = var.AZURE_TENANT_ID
    object_id = var.AZURE_CLIENT_ID

    key_permissions = [
      "Get", "Create", "Delete", "List", "Update", "Verify"
    ]

    secret_permissions = [
      "Get", "Delete", "List", "Set"
    ]

    storage_permissions = [
      "Get", "Delete", "List", "Restore", "Set", "Update"
    ]
  }
}