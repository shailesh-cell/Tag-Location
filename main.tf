# main.tf

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_policy_definition" "tag_policy" {
  name         = "require-tags"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Require specific tags"
  description  = "Ensure specific tags are present on resource groups."

  policy_rule = jsonencode({
    if: {
      allOf: [
        { field: "type", equals: "Microsoft.Resources/subscriptions/resourceGroups" },
        { field: "tags.CostCenter", exists: false }
      ]
    },
    then: {
      effect: "deny"
    }
  })
}

resource "azurerm_resource_policy_assignment" "tag_policy_assignment" {
  name                 = "tag_policy_assignment"
  policy_definition_id = azurerm_policy_definition.tag_policy.id
  scope                = azurerm_resource_group.rg.id
}