variable "HCP_PROJECT_ID" {
  type      = string
  sensitive = true
}

variable "HCP_HVN_ID" {
  type      = string
  sensitive = true
}

variable "HCP_CLOUD_PROVIDER" {
  type    = string
  default = "aws"
}

variable "HCP_HVN_REGION" {
  type    = string
  default = "us-west-2"
  validation {
    condition     = contains(["us-west-2"], var.HCP_HVN_REGION)
    error_message = "The region must be us-west-2."
  }
}

variable "HCP_HVN_CIDR" {
  type = string
}

variable "VAULT_CLUSTER_ID" {
  type = string
}

variable "VAULT_CLUSTER_TIER" {
  type    = string
  default = "plus_small" # Secrets Sync functionality is only available within the HVD Vault Plus tier SKU
  validation {
    condition     = contains(["dev", "starter_small", "standard_small", "plus_small"], var.VAULT_CLUSTER_TIER)
    error_message = "The region must be dev, starter_small, standard_small, or plus_small."
  }
}

variable "VAULT_CLUSTER_PROXY_ENDPOINT" {
  type    = string
  default = "ENABLED"
}

variable "VAULT_CLUSTER_PUBLIC_ENDPOINT" {
  type    = bool
  default = true
}

variable "AWS_REGION" {
  type    = string
  default = "us-east-2"
  validation {
    condition     = contains(["us-east", "us-east-2", "us-west-2"], var.AWS_REGION)
    error_message = "The region must be one of the following: us-east, us-east-2, us-west-2."
  }
}

variable "AWS_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "AWS_SECRET_KEY" {
  type      = string
  sensitive = true
}

variable "AZURE_REGION" {
  type    = string
  default = "East US"
  validation {
    condition     = contains(["East US", "East US 2", "West US"], var.AZURE_REGION)
    error_message = "The region must be one of the following: East US, East US 2, West US."
  }
}

variable "AZURE_CLIENT_ID" {
  type      = string
  sensitive = true
}

variable "AZURE_CLIENT_SECRET" {
  type      = string
  sensitive = true
}

variable "AZURE_TENANT_ID" {
  type      = string
  sensitive = true
}

variable "AZURE_SUBSCRIPTION_ID" {
  type      = string
  sensitive = true
}

variable "AZURE_KEYVAULT_SKU" {
  type    = string
  default = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.AZURE_KEYVAULT_SKU)
    error_message = "The sku_name must be one of the following: standard, premium."
  }
}