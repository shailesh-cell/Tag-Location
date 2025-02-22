resource "azurerm_policy_definition" "location_policy" {
  name         = "location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Allowed Locations"

  metadata = jsonencode({
    "category": "General"
  })

  policy_rule = jsonencode({
    "if" = {
      "field" = "location",
      "notIn" = var.allowed_locations  # Correct way to reference a list in Terraform
    },
    "then" = {
      "effect" = "deny"
    }
  })

  parameters = jsonencode({
    "allowedLocations" = {
      "type" = "Array",
      "metadata" = {
        "description" = "List of allowed locations for resource deployment.",
        "displayName" = "Allowed Locations"
      }
    }
  })
}