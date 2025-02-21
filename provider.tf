# provider.tf

provider "azurerm" {
  features {}

	use_msi                = false
  	use_oidc               = true
  	oidc_cloud_environment = "AzurePublicCloud"
}
