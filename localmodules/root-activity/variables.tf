variable "cloudtrail_log_group_name" {
  type = string
  description = "Cloudtrail cloudwatch log group name"
}

variable "alarm_evaluation_periods" {
  type = number
  description = "The period over which the root account activity metric is evaluated, in seconds"
  default = 300
}

variable "event_bus_name" {
  type = string
  description = "Name of the EventBridge event bus in the account"
  default = null
}