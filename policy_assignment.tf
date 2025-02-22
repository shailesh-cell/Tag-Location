# policy_assignment.tf

resource "azurerm_subscription_policy_assignment" "location_policy_assignment" {
  name                 = "location-policy-assignment"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.location_policy.id
}
