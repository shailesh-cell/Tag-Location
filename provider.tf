# provider.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}

  tenant_id       = "21150d7d-bb5a-486f-86af-73c82a8240bc"

}

