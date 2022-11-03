###
# Public Subnets
###
resource "aws_subnet" "public_subnets" {
  #provider = aws.vpc
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index % length(var.azs))
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name"                   = "${var.environment}-public-${element(var.azs, count.index)}-subnet"
      "kubernetes.io/role/elb" = "1"
    },
    var.tags,
    var.eks_public_subnet_tags
  )
}




###
# Route table for public subnets
###
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }

  tags = merge(
    {
      "Name"    = "${var.environment}-eks-public-subnets"
      "Network" = "Public"
    },
    var.tags,
  )
}

###
# Associate route table with public subnets
# -----------------------------------------
# In current design, we only make 1 public RT, hence all subnets go to that public.id
###
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
