#tag_Policy.tf

data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "tagging_policy" {
  name         = "tagging-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Required Tags"

  policy_rule = <<POLICY_RULE
{
  "if": {
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
  },
  "then": {
    "effect": "Deny"
  }
}
POLICY_RULE

  parameters = <<PARAMETERS
{
  "requiredTags": {
    "type": "Object",
    "metadata": {
      "displayName": "Required Tags",
      "description": "Tags that must be applied to resources."
    },
    "properties": {
      "tag1": {
        "type": "String",
        "metadata": {
          "description": "First required tag"
        }
      },
      "tag2": {
        "type": "String",
        "metadata": {
          "description": "Second required tag"
        }
      },
      "tag3": {
        "type": "String",
        "metadata": {
          "description": "Third required tag"
        }
      }
    }
  }
}
PARAMETERS
}