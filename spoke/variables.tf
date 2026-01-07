variable "hub_account" {
  description = "Account Id for the hub account, e.g., 123456789012"
  type        = string
  validation {
    condition     = length(var.hub_account) == 12 && can(regex("^\\d{12}$", var.hub_account))
    error_message = "Hub account must be a 12-digit number."
  }
}

variable "hub_event_bus_name" {
  type = string
  description = "Name of the EventBridge event bus in the hub account"
} 

variable "cloudtrail_log_group_name" {
  type = string
  description = "Cloudtrail cloudwatch log group name"
}

variable "alarm_evaluation_periods" {
  type = number
  description = "The period over which the root account activity metric is evaluated, in seconds"
  default = 300
}