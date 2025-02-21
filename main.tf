# main.tf

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group_policy_assignment" "tag_policy_assignment" {
  name                 = "tag-policy-assignment"
  display_name         = "Require CostCenter Tag"
  description          = "Ensures that all resource groups have a CostCenter tag."
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
  resource_group_id    = azurerm_resource_group.rg.id

  parameters = jsonencode({
    tagName = {
      value = "CostCenter"  # Replace "CostCenter" with the actual tag name you want to enforce
    }
  })
}
