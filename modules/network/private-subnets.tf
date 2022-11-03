###
# Private Subnets
###
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index % length(var.azs))
  map_public_ip_on_launch = false
  tags = merge(
    {
      "Name" = "${var.environment}-private-${element(var.azs, count.index)}-subnet"
    },
    var.tags,
    var.eks_private_subnet_tags,
  )
}

###
# Route table(s) for private subnets
# ----------------------------------
resource "aws_route_table" "private_route" {
  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.main_vpc.id

  route {
    #cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
  }

  tags = merge(
    {
      "Name" = "${var.environment}-rt-private_subnets-${count.index + 1}"
    },
    var.tags,
  )
}

###
# Associate private route table(s) with private subnets
###
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_route.*.id, count.index)
}
