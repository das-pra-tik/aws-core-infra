variable "env" {
  type    = string
  default = null
}

variable "name" {
  type    = string
  default = null
}

variable "system_name" {
  type    = string
  default = null
}

variable "application_code" {
  type    = string
  default = null
}

variable "system_manager" {
  type    = string
  default = null
}

variable "cost_center" {
  type    = string
  default = null
  validation {
    condition     = length(var.cost_center) == 10 && can(tonumber(var.cost_center))
    error_message = "Cost center is a 10 digit code"
  }
}

variable "component" {
  type    = string
  default = null
}

variable "business_hours" {
  type    = string
  default = "24x7"
}

variable "data_classification" {
  type    = string
  default = null
}

variable "data_access" {
  type    = string
  default = null
}

variable "support_team_email" {
  type    = string
  default = "das_pratik@outlook.com"
}

variable "server_type" {
  type    = string
  default = null
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host"
  type        = string
  default     = null
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = "false"
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = stop
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "private_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block`"
  type        = list(string)
  default     = null
}

variable "private_dns_name_options" {
  description = "Customize the private DNS name options of the instance"
  type        = map(string)
  default     = {}
}

variable "ebs_block_devices" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(any)
  default     = []
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "iops" {
  type    = string
  default = 3000
}

variable "throughput" {
  type    = string
  default = 125
}

variable "volume_size" {
  type    = string
  default = "10"
}

variable "iam_instance_profile" {
  type    = string
  default = null
}

variable "user_data_required" {
  type    = bool
  default = false
}
