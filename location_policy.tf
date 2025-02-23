

resource "azurerm_policy_definition" "location_policy" {
  name         = "location-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Allowed Locations"
  management_group_id = data.azurerm_management_group.Development-mg.id

  metadata = jsonencode({
    "category" = "General"
  })

  parameters = jsonencode({
    "allowedLocations" = {
      "type" = "Array",
      "metadata" = {
        "description" = "List of allowed locations for resource deployment."
        "displayName" = "Allowed Locations"
      }
    }
  })

  policy_rule = jsonencode({
    "if" = {
      "field" = "location",
      "notIn" = "[parameters('allowedLocations')]"  # Correct way to reference the parameter
    },
    "then" = {
      "effect" = "deny"
    }
  })
}