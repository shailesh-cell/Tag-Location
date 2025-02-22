# tag_policy.tf

resource "azurerm_policy_definition" "tagging_policy" {
  name         = "tagging-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Required Tags"

  metadata = <<METADATA
  {
    "category": "General"
  }
  METADATA

  parameters = jsonencode({
    "required_tags" = {
      "type" = "Array"
      "metadata" = {
        "description" = "List of required tags."
        "displayName" = "Required Tags"
      }
    }
  })

  policy_rule = <<POLICY
  {
    "if": {
      "allOf": [
        {
          "field": "[format('tags[{0}]', parameters('required_tags'))]",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
  POLICY
}