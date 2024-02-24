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
    }
  )

  additional_tags = tomap(
    var.additional_tags
  )

  bucket_policy_default_permission = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
    "arn:aws:iam::676285524611:role/devopsbot"
  ]

  bucket_policy_permissions = concat(local.bucket_policy_default_permission, var.bucket_policy_allowed_arns)
}

## s3 bucket policy
data "aws_iam_policy_document" "this" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    principals {
      type        = "AWS"
      identifiers = local.bucket_policy_permissions
    }

    resources = [
      "${aws_s3_bucket.this.arn}/*",
      "${aws_s3_bucket.this.arn}"
    ]
  }
}
