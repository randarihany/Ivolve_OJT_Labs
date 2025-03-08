provider "aws" {
  region = var.region
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
   tags = {
    Name = "main"  # Assign a name tag to the EC2 instance
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}


resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


/*resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block[0]
  availability_zone = "us-east-1a"
  tags = {
    Name = "public subnet"  # Assign a name tag to the EC2 instance
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        =  var.subnet_cidr_block[1]
  availability_zone = "us-east-1a"
   tags = {
    Name = "private subnet"  # Assign a name tag to the EC2 instance
  }
  
}*/

variable "subnet_cidr_blocks" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

resource "aws_subnet" "subnet" {
  for_each          = toset(var.subnet_cidr_blocks) # Converts the list into a set
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = "us-east-1a" # You can dynamically change this if needed

  tags = {
    Name = "Subnet ${each.value}"
  }
}



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups  = [aws_security_group.public_sg.id]  # Allow from public subnet's security group
  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups  = [aws_security_group.public_sg.id]  # Allow from public subnet's security group
  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "public_ec2" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_sg.id] # Use security group ID
  associate_public_ip_address = true 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  
   tags = {
    Name = "Terraform public instance"  # Assign a name tag to the EC2 instance
  }
}


resource "aws_instance" "private_ec2" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id] # Use security group ID
  associate_public_ip_address = false 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  
   tags = {
    Name = "Terraform private instance"  # Assign a name tag to the EC2 instance
  }
}

output "publicEC2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}

output "publicEC2_private_ip" {
  value = aws_instance.public_ec2.private_ip
}

output "privateEC2_private_ip" {
  value = aws_instance.public_ec2.private_ip
}
