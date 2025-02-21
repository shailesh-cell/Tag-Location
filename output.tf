# output.tf

output "policy_name" {
  value       = azurerm_policy_definition.tagging_and_location.name
  description = "The name of the created Azure Policy definition."
}

output "policy_assignment_id" {
  value       = azurerm_subscription_policy_assignment.tagging_and_location.id
  description = "The ID of the assigned Azure Policy to enforce tagging and location restrictions."
}
