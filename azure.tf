resource "azurerm_resource_group" "rg_ss_demo" {
  name     = "rg-ss-demo"
  location = var.AZURE_REGION
}

# Generate a random string to append to Azure Key Vault name
resource "random_string" "kv_ss_demo_str" {
  length  = 6
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Create Azure Key Vault and assign required access policies to defined App registration
resource "azurerm_key_vault" "kv_ss_demo" {
  name                       = "kv-ss-demo-${random_string.kv_ss_demo_str.result}"
  location                   = var.AZURE_REGION
  resource_group_name        = azurerm_resource_group.rg_ss_demo.name
  tenant_id                  = var.AZURE_TENANT_ID
  sku_name                   = var.AZURE_KEYVAULT_SKU
  soft_delete_retention_days = 7
  # enable_rbac_authorization = true

  access_policy {
    tenant_id = var.AZURE_TENANT_ID
    object_id = var.AZURE_OBJECT_ID

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