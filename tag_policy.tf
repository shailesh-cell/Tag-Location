# tag_policy.tf

resource "azurerm_policy_definition" "tagging_policy" {
  name         = "tagging-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Required Tags"

  metadata = jsonencode({
    "category": "General"
  })

  policy_rule = jsonencode({
    "if" = {
      "allOf" = [
        for tag in var.required_tags : {
          "field"  = "tags['${tag}']"
          "exists" = "false"
        }
      ]
    },
    "then" = {
      "effect" = "deny"
    }
  })

  parameters = jsonencode({
    "required_tags" = {
      "type" = "Array",
      "metadata" = {
        "description" = "The list of required tags for resources.",
        "displayName" = "Required Tags"
      }
    }
  })
}