data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "tagging_and_location" {
  name         = "tagging-and-location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Tags and Allowed Locations"

  policy_rule = <<POLICY_RULE
{
  "properties": {
    "displayName": "Enforce Tags and Allowed Locations",
    "policyType": "Custom",
    "mode": "All",
    "metadata": {
      "category": "Tags"
    },
    "parameters": {
      "allowedLocations": {
        "type": "Array",
        "metadata": {
          "displayName": "Allowed Locations",
          "description": "The list of locations where resources can be created."
        },
        "allowedValues": [${join(",", var.allowed_locations)}]
      },
      "requiredTags": {
        "type": "Object",
        "metadata": {
          "displayName": "Required Tags",
          "description": "Tags that must be applied to resources."
        }
      }
    },
    "policyRule": {
      "if": {
        "not": {
          "field": "location",
          "in": "[parameters('allowedLocations')]"
        }
      },
      "then": {
        "effect": "Deny"
      }
    },
    "if": {
      "allOf": [
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
}
POLICY_RULE

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": ${jsonencode(var.allowed_locations)}
  },
  "requiredTags": {
    "value": ${jsonencode(var.required_tags)}
  }
}
PARAMETERS
}