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
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
