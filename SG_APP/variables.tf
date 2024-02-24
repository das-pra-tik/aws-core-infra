variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "sec_grp_type" {
  type = string
}

variable "application_code" {
  type = string
}

variable "system_manager" {
  type = string
}

variable "cost_center" {
  type = string
  validation {
    condition     = length(var.cost_center) == 10 && can(tonumber(var.cost_center))
    error_message = "Cost center is a 10 digit code. Please validate in https://gnet.gilead.com"
  }
}

variable "component" {
  type = string
}

variable "gxp" {
  type = string
}

variable "business_hours" {
  type    = string
  default = "24x7"
}

variable "data_classification" {
  type = string
}

variable "data_access" {
  type = string
}

variable "support_team_email" {
  type = string
}

variable "sg_ingress_rules" {
  type = any
}