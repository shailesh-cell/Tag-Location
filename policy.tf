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
              "field": "[concat('tags[', parameters('requiredTags').tag1, ']')]",
              "exists": "true"
            }
          },
          {
            "not": {
              "field": "[concat('tags[', parameters('requiredTags').tag2, ']')]",
              "exists": "true"
            }
          },
          {
            "not": {
              "field": "[concat('tags[', parameters('requiredTags').tag3, ']')]",
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
    "defaultValue": {
      "tag1": "CostCenter",
      "tag2": "Environment",
      "tag3": "Owner"
    }
  }
}
PARAMETERS
}

variable "allowed_locations" {
  description = "List of allowed locations for resource creation"
  type        = list(string)
}

variable "required_tags" {
  description = "Required tags for resources"
  type        = map(string)
}
