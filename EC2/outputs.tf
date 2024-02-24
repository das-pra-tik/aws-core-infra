output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "private_ip" {
  value = module.ec2.private_ip
}

output "ebs_volume_data" {
  value = aws_ebs_volume.this
}

output "aws_volume_attachment_data" {
  value = aws_volume_attachment.this
}
