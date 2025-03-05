provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
   tags = {
    Name = "main"  # Assign a name tag to the EC2 instance
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
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

resource "aws_security_group" "nginx_sg" {
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

resource "aws_instance" "nginx" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id] # Use security group ID
  associate_public_ip_address = true 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  lifecycle {
    create_before_destroy = true
  }
  
   tags = {
    Name = "NEWW -TerraformEC2Instance"  # Assign a name tag to the EC2 instance
    Replacement = timestamp() # Forces replacement
  }
}

resource "aws_sns_topic" "alerts" {
  name = "cpu-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "randarihany@gmail.com" # Replace with your email
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name                = "high-cpu-usage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 70
  alarm_actions             = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = aws_instance.nginx.id
  }
}


output "nginx_public_ip" {
  value = aws_instance.nginx.public_ip
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
