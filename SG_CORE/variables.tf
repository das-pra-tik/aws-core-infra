variable "vpc_id" {
  type = string
}
variable "env" {
  type = string
}
variable "region" {
  type = string
}

### CORE SERVICES SG VARIABLES STARTS
variable "core_services_linux_ingress_rules" {
  default = [
    {
      description = "All ICMP"
      from_port   = "-1"
      to_port     = "-1"
      protocol    = "icmp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "SSH Inbound"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "SBRG Inbound"
      from_port   = 5985
      to_port     = 5985
      protocol    = "tcp"
      cidrs = [
        "10.118.170.130/32"
      ]
    },
    {
      description = "RPC Inbound"
      from_port   = 135
      to_port     = 135
      protocol    = "tcp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "SMB Inbound"
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "GPV Inbound"
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      cidrs = [
        "10.118.171.198/32",
        "10.118.168.31/32",
        "10.118.170.183/32",
        "10.119.168.76/32",
        "10.119.168.45/32"
      ]
    },
    {
      description = "UDP Inbound"
      from_port   = 161
      to_port     = 161
      protocol    = "udp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "Nexpose Inbound"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidrs = [
        "10.87.4.80/32",
        "10.200.100.91/32",
        "10.64.4.22/32",
        "10.22.35.9/32",
        "10.50.40.62/32",
        "10.60.5.182/32",
        "10.42.32.85/32",
        "10.22.35.10/32",
        "10.22.37.36/32",
        "10.57.4.43/32"
      ]
    },
    {
      description = "SolarWinds"
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      cidrs = [
        "10.22.36.136/32",
        "10.42.32.48/32",
        "10.22.36.179/32",
        "10.42.32.46/32",
        "10.22.36.178/32",
        "10.42.32.47/32",
        "10.22.36.173/32",
        "10.22.36.172/32",
        "10.22.36.174/32",
        "10.22.36.199/32",
        "10.22.36.197/32",
        "10.118.176.97/32",
        "10.42.6.73/32",
        "10.42.6.74/32",
        "10.22.36.87/32",
        "10.22.36.200/32",
        "10.22.118.78/32",
        "10.22.118.176/32",
        "10.118.179.119/32",
        "10.141.160.138/32",
        "10.142.15.184/32",
        "10.60.4.229/32",
        "10.89.4.164/32",
        "10.60.4.253/32",
        "10.87.4.100/32",
        "10.88.4.108/32",
        "10.200.100.98/32",
        "10.5.100.117/32",
        "10.3.100.49/32"
      ]
    }
  ]
}

variable "core_services_linux_egress_rules" {
  default = [
    {
      description = "All Outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidrs       = ["0.0.0.0/0"]
    }
  ]
}

variable "core_services_windows_ingress_rules" {
  default = [
    {
      description = "All ICMP"
      from_port   = "-1"
      to_port     = "-1"
      protocol    = "icmp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "RDP Inbound"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "SBRG Inbound"
      from_port   = 5985
      to_port     = 5985
      protocol    = "tcp"
      cidrs = [
        "10.118.170.130/32"
      ]
    },
    {
      description = "RPC Inbound"
      from_port   = 135
      to_port     = 135
      protocol    = "tcp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "SMB Inbound"
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "GPV Inbound"
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      cidrs = [
        "10.118.171.198/32",
        "10.118.168.31/32",
        "10.118.170.183/32",
        "10.119.168.76/32",
        "10.119.168.45/32"
      ]
    },
    {
      description = "UDP Inbound"
      from_port   = 161
      to_port     = 161
      protocol    = "udp"
      cidrs       = ["10.0.0.0/8"]
    },
    {
      description = "Nexpose Inbound"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidrs = [
        "10.87.4.80/32",
        "10.200.100.91/32",
        "10.64.4.22/32",
        "10.22.35.9/32",
        "10.50.40.62/32",
        "10.60.5.182/32",
        "10.42.32.85/32",
        "10.22.35.10/32",
        "10.22.37.36/32",
        "10.57.4.43/32"
      ]
    },
    {
      description = "SolarWinds"
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      cidrs = [
        "10.22.36.136",
        "10.42.32.48",
        "10.22.36.179",
        "10.42.32.46",
        "10.22.36.178",
        "10.42.32.47",
        "10.22.36.173",
        "10.22.36.172",
        "10.22.36.174",
        "10.22.36.199",
        "10.22.36.197",
        "10.118.176.97",
        "10.42.6.73",
        "10.42.6.74",
        "10.22.36.87",
        "10.22.36.200",
        "10.22.118.78",
        "10.22.118.176",
        "10.118.179.119",
        "10.141.160.138",
        "10.142.15.184",
        "10.60.4.229",
        "10.89.4.164",
        "10.60.4.253",
        "10.87.4.100",
        "10.88.4.108",
        "10.200.100.98",
        "10.5.100.117",
        "10.3.100.49"
      ]
    }
  ]
}

variable "core_services_windows_egress_rules" {
  default = [
    {
      description = "All Outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidrs       = ["0.0.0.0/0"]
    }
  ]
}