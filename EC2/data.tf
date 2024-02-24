data "aws_ami" "ami_id" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  prefix = "${var.env}${terraform.workspace == "default" ? "" : "-${terraform.workspace}"}"
  common_tags = tomap(
    {
      "terraform" : "true"
      "environment" : var.env
      "workspace" : terraform.workspace
      "managed_by" : "DevOps"
    }
  )
  project_tags = tomap(
    {
      "Name" : upper(var.name)
      "system-name" : var.system_name
      "application-code" : var.application_code
      "system-manager" : var.system_manager
      "cost-center" : var.cost_center
      "component" : var.component
      "gxp" : var.gxp
      "business-hours" : var.business_hours
      "data-classification" : var.data_classification
      "data-access" : var.data_access
      "support-team-email" : var.support_team_email
      "server-type" : "type-${var.server_type}"
    }
  )
  additional_tags = tomap(
    var.additional_tags
  )

  backup_tags = tomap(
    { "backup-plan" : "default" }
  )

  user_data_required = var.user_data_required
  user_data_path     = "./scripts/ec2_user_data/${var.env}/${var.name}.sh"
}

data "template_file" "user_data_scripts" {
  template = local.user_data_required == false ? "" : file(local.user_data_path)
}
