# Create Internet Gateway
#----------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.web_vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}


# Create elastic IP
#----------------------------------------------------
resource "aws_eip" "eip" {
  count = 2

  tags = {
    Name = "${var.project_name}-eip${count.index + 1}"
  }
}


# Create NAT Gateway
#----------------------------------------------------
resource "aws_nat_gateway" "nat_gw" {
  count = 2
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public_subnets["public-subnet-${count.index + 1}"].id

  tags = {
    Name = "${var.project_name}-nat${count.index + 1}"
  }
}