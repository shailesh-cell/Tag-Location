
# Reference the existing Management Group
data "azurerm_management_group" "Development-mg" {
  name = "Development-mg"  # Name of the existing Management Group
}