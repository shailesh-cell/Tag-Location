# output.tf

output "location_policy_name" {
  value       = azurerm_policy_definition.location_policy.name
  description = "The name of the created Azure Policy definition for allowed locations."
}

output "location_policy_assignment_id" {
  value       = azurerm_subscription_policy_assignment.location_policy_assignment.id
  description = "The ID of the assigned Azure Policy to enforce location restrictions."
}

output "tagging_policy_name" {
  value       = azurerm_policy_definition.tagging_policy.name
  description = "The name of the created Azure Policy definition for required tags."
}

output "tagging_policy_assignment_id" {
  value       = azurerm_subscription_policy_assignment.tagging_policy_assignment.id
  description = "The ID of the assigned Azure Policy to enforce required tagging."
}
