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
        "anyOf": [
          {
            "not": {
              "field": "[concat('tags[', 'CostCenter', ']')]",
              "exists": "true"
            }
          },
          {
            "not": {
              "field": "[concat('tags[', 'Environment', ']')]",
              "exists": "true"
            }
          },
          {
            "not": {
              "field": "[concat('tags[', 'Owner', ']')]",
              "exists": "true"
            }
          }
        ]
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
    },
    "properties": {
      "CostCenter": {
        "type": "String",
        "metadata": {
          "description": "Cost Center tag"
        }
      },
      "Environment": {
        "type": "String",
        "metadata": {
          "description": "Environment tag"
        }
      },
      "Owner": {
        "type": "String",
        "metadata": {
          "description": "Owner tag"
        }
      }
    }
  }
}
PARAMETERS
}
