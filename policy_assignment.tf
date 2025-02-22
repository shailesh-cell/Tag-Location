# policy_assignment.tf

data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "tagging_policy_assignment" {
  name                 = "tagging-policy-assignment"
  policy_definition_id = azurerm_policy_definition.tagging_policy.id

}



resource "azurerm_subscription_policy_assignment" "location_policy_assignment" {
  name                 = "location-policy-assignment"
  policy_definition_id = azurerm_policy_definition.location_policy.id

)
