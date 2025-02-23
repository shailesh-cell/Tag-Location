# tag_policy.tf

resource "azurerm_management_group" "Development-mg" { 
  display_name = "Development Management Group"
}

resource "azurerm_policy_definition" "tagging_policy" {
  name         = "tagging-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce Required Tags"
  management_group_id = azurerm_management_group.Development-mg.id

  metadata = <<METADATA
  {
    "category": "General"
  }
  METADATA

  parameters = jsonencode({
    "required_tags" = {
      "type" = "Object"
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
          "field": "tags['CostCenter']",
          "notEquals": "[parameters('required_tags')['CostCenter']]"
        },
	
	{
	  "field": "tags['Environment']",
          "notEquals": "[parameters('required_tags')['Environment']]"   
	}
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
  POLICY
}