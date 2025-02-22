# location_policy.tf

resource "azurerm_policy_definition" "location_policy" {
  name         = "location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Allowed Locations"

  metadata = <<METADATA
  {
    "category": "General"
  }
  METADATA

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

  parameters = jsonencode({
    "allowedLocations" = {
      "value" = var.allowed_locations  # Now using a variable instead of hardcoded values
    }
  })
}