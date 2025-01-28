# Define HCP network
resource "hcp_hvn" "hvn_demo" {
  hvn_id         = var.HCP_HVN_ID
  cloud_provider = var.HCP_CLOUD_PROVIDER
  region         = var.HCP_HVN_REGION
  cidr_block     = var.HCP_HVN_CIDR
}

# Create HCP Vault Dedicated cluster
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

# Generate Vault Admin token
resource "hcp_vault_cluster_admin_token" "vault_admin_token" {
  cluster_id = hcp_vault_cluster.vault_demo.cluster_id
}

# Create KVV2 secrets engine mount
resource "vault_mount" "kvv2" {
  path    = "kvv2"
  type    = "kv"
  options = { version = "2" }
}

# Create pre-populated secret for demo showcase
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