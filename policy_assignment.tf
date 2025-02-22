# policy assignment.tf

resource "azurerm_policy_assignment" "tagging_policy_assignment" {
  name                 = "tagging-policy-assignment"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.tagging_policy.id

  parameters = <<PARAMETERS
{
  "requiredTags": {
    "value": {
      "tag1": "CostCenter",
      "tag2": "Environment",
      "tag3": "Owner"
    }
  }
}
PARAMETERS
}

resource "azurerm_policy_assignment" "location_policy_assignment" {
  name                 = "location-policy-assignment"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.location_policy.id

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": ["centralindia", "southindia", "westindia"]
  }
}
PARAMETERS
}
