# backend.tf

terraform {
  backend "azurerm" {
    tenant_id           = "21150d7d-bb5a-486f-86af-73c82a8240b"
    subscription_id     = "a6435a3c-312e-41ed-878b-3118525f919a"
    resource_group_name   = "terraform_tfstate_rg"
    storage_account_name  = "terraformconfigsa"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
    use_oidc              = true  # Enable OIDC authentication
  }
}
