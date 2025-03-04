
# Create an EC2 instance in the public subnet
resource "aws_instance" "ec2_instance" {
  ami           = "ami-05b10e08d247fb927"  # Specify the AMI ID for the EC2 instance
  instance_type = "t2.micro"               # Specify the instance type
  associate_public_ip_address = true       # Automatically assign a public IP address to the instance
  subnet_id = aws_subnet.public_subnet.id  # Attach the EC2 instance to the public subnet
  
  # Optional: Security group (commented out, can be added later)
  # security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "TerraformEC2Instance"  # Assign a name tag to the EC2 instance
  }
  
  # Provisioner to execute local commands after the instance is created
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-public-ip.txt"  # Write the public IP to a file
  }
}
