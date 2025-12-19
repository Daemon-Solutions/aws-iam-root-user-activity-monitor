variable "hub_account_id" {
  type = string

}

variable "spoke_account_id" {
  type = string
}


variable "spoke_account_external_id" {
  type = string
}

variable "spoke_account_assume_role_arn" {
  type    = string
}