# provider.tf

provider "azurerm" {
  features {}

  use_oidc        = true  # Enables OIDC authentication
}