# location_policy.tf

resource "azurerm_policy_definition" "location_policy" {
  name         = "location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Allowed Locations"

  metadata = <<EOT
  {
    "category": "General"
  }
  EOT

  policy_rule = <<POLICY
  {
    "if": {
      "field": "location",
      "notIn": [${join(",", var.allowed_locations)}]
    },
    "then": {
      "effect": "deny"
    }
  }
  POLICY
}