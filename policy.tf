#Policy.tf

data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "tagging_and_location" {
  name         = "tagging-and-location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Tags and Allowed Locations"

  policy_rule = <<POLICY_RULE
{
  "if": {
    "allOf": [
      {
        "field": "location",
        "notIn": "[parameters('allowedLocations')]"
      },
      {
        "not": {
          "field": "[concat('tags[', keys(parameters('requiredTags'))[0], ']')]",
          "exists": "true"
        }
      },
      {
        "not": {
          "field": "[concat('tags[', keys(parameters('requiredTags'))[1], ']')]",
          "exists": "true"
        }
      }
    ]
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
  },
  "requiredTags": {
    "type": "Object",
    "metadata": {
      "displayName": "Required Tags",
      "description": "Tags that must be applied to resources."
    }
  }
}
PARAMETERS
}