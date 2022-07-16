variable "clientid" {
  description = "Azure Client ID"
  type        = string
  sensitive   = true
}

variable "clientsecret" {
  description = "Azure Client Service Principal Secret"
  type        = string
  sensitive   = true
}

variable "subscriptionid" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "tenantid" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "testpassword" {
  description = "Generic Global Test Password"
  type        = string
  sensitive   = true
}

