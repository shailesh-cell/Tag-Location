# variables.tf

variable "allowed_locations" {
  description = "List of allowed Azure regions for deployment"
  type        = list(string)
  default     = ["centralindia", "southindia", "westindia"]
}

variable "required_tags" {
  type        = map(string)
  description = "Tags that must be applied to all resources"
  default     = {
    CostCenter  = "FreeTier"
    Environment = "Production"
    Owner       = "DevOps Team"
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}