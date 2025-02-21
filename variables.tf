#variable.tf

variable "allowed_locations" {
  description = "List of allowed Azure regions for deployment"
  type        = list(string)
}

variable "required_tags" {
  type        = map(string)
  description = "Tags that must be applied to all resources"
}
