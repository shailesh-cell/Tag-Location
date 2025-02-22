# policy_assignment.tf

data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "tagging_policy_assignment" {
  name                 = "tagging-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.tagging_policy.id

  parameters = jsonencode({
    "required_tags" = {
      "value" = var.required_tags
    }
  })
}

resource "azurerm_subscription_policy_assignment" "location_policy_assignment" {
  name                 = "location-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.location_policy.id

  parameters = jsonencode({
    "allowedLocations" = {
      "value" = var.allowed_locations
    }
  })
}


