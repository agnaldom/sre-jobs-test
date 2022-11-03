# -------------------------------------------------------------
# VPC outputs
# -------------------------------------------------------------
output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR of the overall environment config (covering all subnets)"
  value       = var.vpc_cidr
}
