#location_Policy.tf

data "azurerm_subscription" "current_location_policy" {}

resource "azurerm_policy_definition" "location_policy" {
  name         = "location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Allowed Locations"

  policy_rule = <<POLICY_RULE
{
  "if": {
    "field": "location",
    "notIn": "[parameters('allowedLocations')]"
  },
  "then": {
    "effect": "Deny"
  }
}
POLICY_RULE

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "type": "Array",
    "metadata": {
      "displayName": "Allowed Locations",
      "description": "The list of locations where resources can be created."
    }
  }
}
PARAMETERS
}