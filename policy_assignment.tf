# policy_assignment.tf

resource "azurerm_management_group_policy_assignment" "tagging_policy_assignment" {
  name                 = "tagging-policy-assignment"
  management_group_id      = azurerm_management_group.Development-mg.id
  policy_definition_id = azurerm_policy_definition.tagging_policy.id

  parameters = jsonencode({
    "required_tags" = {
      "value" = var.required_tags
    }
  })
}

resource "azurerm_management_group_policy_assignment" "location_policy_assignment" {
  name                 = "location-policy-assignment"
  management_group_id      = azurerm_management_group.Development-mg.id
  policy_definition_id = azurerm_policy_definition.location_policy.id

  parameters = jsonencode({
    "allowedLocations" = {
      "value" = var.allowed_locations
    }
  })
}


