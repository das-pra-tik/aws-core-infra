variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "system_name" {
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
    error_message = "Cost center is a 10 digit code"
  }
}

variable "component" {
  type    = string
  default = "storage"
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

variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "kms_key_id" {
  type = string
}

variable "default_retention_noncurrent_days" {
  type    = string
  default = 180
}

variable "archive_retention_noncurrent_days" {
  type    = string
  default = 90
}

variable "bucket_policy_allowed_arns" {
  type    = list(string)
  default = []
}
