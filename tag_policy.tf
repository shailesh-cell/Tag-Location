# tag_policy.tf

resource "azurerm_policy_definition" "tagging_policy" {
  name         = "tagging-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Required Tags"

  metadata = <<EOT
  {
    "category": "General"
  }
  EOT

  policy_rule = <<POLICY
  {
    "if": {
      "allOf": [
        {
          "field": "[concat('tags[', parameters('tagName'), ']')]",
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
