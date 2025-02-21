# provider.tf

provider "azurerm" {
  features {}

  use_oidc        = true  # Enables OIDC authentication
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}