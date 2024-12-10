terraform {
  required_version = ">=1.9.3"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "=0.100.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "=4.5.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "=5.80.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}