locals {
  prefix = "${var.environment}${terraform.workspace == "default" ? "" : "-${terraform.workspace}"}"
  common_tags = tomap(
    {
      "terraform" : "true"
      "environment" : var.environment
      "workspace" : terraform.workspace
      "managed_by" : "DevOps"
    }
  )
  project_tags = tomap(
    {
      "Name" : "SG-${upper(var.environment)}-${upper(var.application_code)}-${upper(var.sec_grp_type)}-${var.region}"
      "application-code" : var.application_code
      "system-manager" : var.system_manager
      "cost-center" : var.cost_center
      "component" : var.component
      "gxp" : var.gxp
      "business-hours" : var.business_hours
      "data-classification" : var.data_classification
      "data-access" : var.data_access
      "support-team-email" : var.support_team_email
    }
  )
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
