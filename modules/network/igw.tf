###
# Internet Gateway
# ----------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = "${var.project_name}-igw"
    },
    var.tags,
  )
}
