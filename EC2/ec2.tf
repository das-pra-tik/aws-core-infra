locals {
  create = var.create
}

################################################################################
# EC2 Instance
################################################################################
resource "aws_instance" "ec2_instance" {
  count                                = local.create ? 1 : 0
  ami                                  = data.aws_ami.ami_id.id
  instance_type                        = var.instance_type
  iam_instance_profile                 = var.iam_instance_profile
  key_name                             = var.key_name
  associate_public_ip_address          = false
  private_ip                           = var.private_ip
  secondary_private_ips                = var.secondary_private_ips
  tenancy                              = var.tenancy
  subnet_id                            = var.private_subnet_id
  vpc_security_group_ids               = var.vpc_security_group_ids
  source_dest_check                    = var.source_dest_check
  availability_zone                    = var.availability_zone
  ebs_optimized                        = var.ebs_optimized
  monitoring                           = var.monitoring
  disable_api_termination              = true
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  user_data                            = data.template_file.user_data_scripts.rendered
  lifecycle {
    ignore_changes = [ami]
  }

  tags = merge(
    local.common_tags, local.project_tags, local.backup_tags, local.additional_tags
  )

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    kms_key_id            = var.kms_key_id
    volume_type           = var.volume_type
    iops                  = var.iops
    throughput            = var.throughput
    volume_size           = var.root_vol_size
    tags = merge(
      local.common_tags, local.project_tags, local.additional_tags
    )
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
}

resource "aws_ebs_volume" "ebs_vol" {
  count             = length(var.ebs_block_devices)
  size              = var.volume_size[count.index]
  type              = var.volume_type
  availability_zone = var.availability_zone
  encrypted         = true
  kms_key_id        = var.kms_key_id
  tags = merge(
    local.common_tags, local.project_tags, local.additional_tags
  )
}

resource "aws_volume_attachment" "ebs_vol_attach" {
  count        = length(var.ebs_block_devices)
  device_name  = var.ebs_block_devices[count.index].device_name
  instance_id  = aws_instance.ec2_instance.id
  volume_id    = aws_ebs_volume.ebs_vol[count.index].id
  force_detach = true
}

resource "private_dns_name_options" "this" {
  for_each = length(var.private_dns_name_options) > 0 ? [var.private_dns_name_options] : []
  content {
    hostname_type                        = try(private_dns_name_options.value.hostname_type, null)
    enable_resource_name_dns_a_record    = try(private_dns_name_options.value.enable_resource_name_dns_a_record, null)
    enable_resource_name_dns_aaaa_record = try(private_dns_name_options.value.enable_resource_name_dns_aaaa_record, null)
  }
}

