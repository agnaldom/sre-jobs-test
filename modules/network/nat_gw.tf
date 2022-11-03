###
# NAT Gateway(s)
# --------------
resource "aws_nat_gateway" "nat_gw" {
  count = length(var.public_subnet_cidrs)

  allocation_id = element(aws_eip.elastic_ip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  tags = merge(
    {
      "Name" = "${var.environment}-natgw-${count.index + 1}"
    },
    var.tags,
  )
  depends_on = [aws_internet_gateway.eks-igw]
}

resource "aws_route" "nat_gtw" {
  count = length(var.private_subnet_cidrs)

  route_table_id         = element(aws_route_table.private_route.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)
}
