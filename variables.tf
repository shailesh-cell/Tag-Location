# variables.tf

variable "allowed_locations" {
  description = "List of allowed Azure regions for deployment"
  type        = list(string)
}

variable "required_tags" {
  description = "Tags that must be applied to all resources"
  type        = list(string)  # Changed from map(string) to list(string) for consistency
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}