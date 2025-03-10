provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "main"
  }
}
resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.subnet["10.0.0.0/24"].id
  allocation_id = aws_eip.nat_eip.id  # Reference the allocation ID of the Elastic IP

  tags = {
    Name = "NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "subnet" {
  for_each = toset(var.subnet_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = element(var.subnet_az, index(var.subnet_cidr_blocks, each.value))

  tags = {
    Name = element(var.subnet_name, index(var.subnet_cidr_blocks, each.value))
  }
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
    from_port      = 80
    to_port        = 80
    protocol       = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  ingress {
    from_port      = 22
    to_port        = 22
    protocol       = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  for_each = local.instances

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet[each.value.subnet_cidr].id
  vpc_security_group_ids = [each.value.security_group_id]
  associate_public_ip_address = each.value.associate_public_ip

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = each.value.instance_name
  }
}

# Local map for instances
locals {
  instances = {
    "public_instance" = {
      subnet_cidr         = "10.0.0.0/24"
      security_group_id   = aws_security_group.public_sg.id
      instance_name       = "Public EC2 Instance"
      associate_public_ip = true
    },
    "private_instance" = {
      subnet_cidr         = "10.0.1.0/24"
      security_group_id   = aws_security_group.private_sg.id
      instance_name       = "Private EC2 Instance"
      associate_public_ip = false
    }
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
  subnet_id      = aws_subnet.subnet["10.0.0.0/24"].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet["10.0.1.0/24"].id
  route_table_id = aws_route_table.private.id
}


output "publicEC2_public_ip" {
  value = aws_instance.ec2_instance["public_instance"].public_ip
}

output "publicEC2_private_ip" {
  value = aws_instance.ec2_instance["public_instance"].private_ip
}

output "privateEC2_private_ip" {
  value = aws_instance.ec2_instance["private_instance"].private_ip
}
