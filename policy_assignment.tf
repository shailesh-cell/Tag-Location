# policy assignment.tf

resource "azurerm_subscription_policy_assignment" "tagging_and_location" {
  name                 = "tagging-and-location-assignment"
  policy_definition_id = azurerm_policy_definition.tagging_and_location.id
  subscription_id      = data.azurerm_subscription.current.id

  parameters = jsonencode({
    allowedLocations = { "value": var.allowed_locations }
    requiredTags     = { "value": var.required_tags }
  })
}
