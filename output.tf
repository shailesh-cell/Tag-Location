# output.tf

output "policy_name" {
  value       = azurerm_policy_definition.location_policy.name
  description = "The name of the created Azure Policy definition."
}

output "policy_assignment_id" {
  value       = azurerm_subscription_policy_assignment.location_policy_assignment.id
  description = "The ID of the assigned Azure Policy to enforce tagging and location restrictions."
}

output "policy_name" {
  value       = azurerm_policy_definition.tagging_policy.name
  description = "The name of the created Azure Policy definition."
}

output "policy_assignment_id" {
  value       = azurerm_subscription_policy_assignment.tagging_policy_assignment.id
  description = "The ID of the assigned Azure Policy to enforce tagging and location restrictions."
}


