output "id" {
  value = aws_s3_bucket.this.id
}

output "aws_s3_arn" {
  value = aws_s3_bucket.this.arn
}

output "aws_s3_tags" {
  value = aws_s3_bucket.this.tags_all
}

output "account" {
  value = data.aws_caller_identity.current
}