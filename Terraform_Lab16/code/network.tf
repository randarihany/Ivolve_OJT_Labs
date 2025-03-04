
# Import an existing VPC 
# To import the VPC into Terraform: terraform import aws_vpc.main vpc-0c2d15a417e3da752
resource "aws_vpc" "main" {
  # No configuration needed here since we're importing an existing VPC
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  # Attach the gateway to the main VPC

  tags = {
    Name = "IGW"  # Assign a name tag to the internet gateway
  }
}

# Create a public subnet within the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id      # Attach the subnet to the main VPC
  cidr_block = "10.0.1.0/24"        # Define the CIDR block for the subnet
  availability_zone = "us-east-1a"   # Specify the availability zone

  tags = {
    Name = "public subnet"  # Assign a name tag to the subnet
  }
}

# Create a private subnet within the VPC
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id      # Attach the subnet to the main VPC
  cidr_block = "10.0.2.0/24"        # Define the CIDR block for the subnet
  availability_zone = "us-east-1a"   # Specify the availability zone

  tags = {
    Name = "private subnet"  # Assign a name tag to the subnet
  }
}

# Create a route table for the public subnet that routes traffic through the internet gateway (IGW)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id  # Attach the route table to the main VPC

  # Define a route that sends all traffic (0.0.0.0/0) to the internet gateway
  route {
    cidr_block = "0.0.0.0/0"  # Route all traffic
    gateway_id = aws_internet_gateway.igw.id  # Route traffic through the IGW
  }

  tags = {
    Name = "Public subnet rt"  # Assign a name tag to the route table
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id   # Reference to the public subnet
  route_table_id = aws_route_table.public_rt.id  # Reference to the public route table
}
