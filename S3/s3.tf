#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "this" {
  bucket = "${var.name}-${var.env}-${data.aws_region.current.name}"

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    local.common_tags, local.project_tags, local.additional_tags,
    {
      Name = lower("${var.name}-${var.env}-${data.aws_region.current.name}")
    }
  )
}

resource "aws_s3_bucket_versioning" "this" {
  depends_on = [aws_s3_bucket.this]

  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  depends_on = [aws_s3_bucket_versioning.this]

  bucket = aws_s3_bucket.this.id

  rule {
    id     = "default"
    status = "Enabled"
    noncurrent_version_expiration {
      noncurrent_days = var.default_retention_noncurrent_days
    }
  }

  rule {
    id     = "archive_retention"
    status = "Enabled"
    noncurrent_version_expiration {
      noncurrent_days = var.archive_retention_noncurrent_days
    }
    filter {
      prefix = "archives"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  depends_on = [aws_s3_bucket_lifecycle_configuration.this]

  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  depends_on = [aws_s3_bucket_public_access_block.this]

  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  depends_on = [aws_s3_bucket_server_side_encryption_configuration.this]

  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# resource "aws_s3_bucket_acl" "this" {
#   depends_on = [aws_s3_bucket_ownership_controls.this]

#   bucket = aws_s3_bucket.this.id
#   acl    = "private"
# }

resource "aws_s3_bucket_policy" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}
