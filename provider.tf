# provider.tf

provider "azurerm" {
  features {}

  subscription_id = data.azurerm_key_vault_secret.subscription_id.value
  client_id       = data.azurerm_key_vault_secret.client_id.value
  client_secret   = data.azurerm_key_vault_secret.client_secret.value
  tenant_id       = data.azurerm_key_vault_secret.tenant_id.value
}

data "azurerm_key_vault" "example" {
  name                = "azuresecretscredentials"
  resource_group_name = "terraform_tfstate_rg"
}

data "azurerm_key_vault_secret" "subscription_id" {
  name         = "subscription-id"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "client_id" {
  name         = "client-id"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = "client-secret"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "tenant_id" {
  name         = "tenant-id"
  key_vault_id = data.azurerm_key_vault.example.id
}