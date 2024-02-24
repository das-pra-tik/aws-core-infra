output "sg_core_linux_id" {
  value = aws_security_group.core_services_linux.id
}

output "sg_core_linux_name" {
  value = aws_security_group.core_services_linux.name
}

output "sg_core_windows_id" {
  value = aws_security_group.core_services_windows.id
}

output "sg_core_windows_name" {
  value = aws_security_group.core_services_windows.name
}