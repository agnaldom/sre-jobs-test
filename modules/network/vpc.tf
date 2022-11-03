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
