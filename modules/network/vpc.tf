###
# Virtual Private Cloud (VPC)
###
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy
  tags = merge(
    {
      "Name" = var.vpc_name
    },
    var.tags,
  )
}

###
# Elastic IP(s) for NAT Gateway(s) 
# --------------------------------
# See NAT Gateway(s) for the logic on enable_igw
###
resource "aws_eip" "elastic_ip" {
  count = length(var.public_subnet_cidrs)

  vpc = true
  tags = merge(
    {
      "Name" = "${var.environment}-eks-eip-gateway-az-${count.index + 1}"
    },
    var.tags,
  )
}
