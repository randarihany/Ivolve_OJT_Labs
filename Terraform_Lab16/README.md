Lab 16: Multi-Tier Application Deployment with Terraform
﻿﻿Create a VPC manually.
﻿﻿Make Terraform manage this VPC.
﻿﻿Implement the below diagram with Terraform.
﻿﻿Use local provisioner to write the EC2 IP in a file called ec2-ip.txt.

Architecture:
![arch](https://github.com/user-attachments/assets/d2e8c610-379e-4f4d-bdb1-a231a0ee94de)

---

1. Create a VPC resource manually in AWS:

You can create a VPC manually through the AWS Management Console or use the AWS CLI. 
Here, I’ll guide you through creating a VPC manually via the AWS Management Console:

Go to the AWS VPC Dashboard.
Click Create VPC.
Choose the VPC only option (without additional resources).
Configure the VPC with the following settings:
IPv4 CIDR Block: For example, 10.0.0.0/16.
Tenancy: Default (unless you need dedicated instances).
Click Create.
Note down the VPC ID and Subnets that are created.

**VPC Configurations:**

![image](https://github.com/user-attachments/assets/16666fde-6ca0-4007-b0fd-4e7f7ad3c9bb)

**VPC Outputs:**

![image](https://github.com/user-attachments/assets/b3f79f71-0f61-40e7-97b2-65ee34d875dc)  


```
terraform init
terraform apply
terraform import aws_vpc.main vpc-0c2d15a417e3da752
```
**Import Result:**

![image](https://github.com/user-attachments/assets/3c0b9051-2726-459f-9a29-c240c9d553eb)


2. Set up Terraform
Once the VPC is created manually, you can now use Terraform to manage it. Below is an example Terraform configuration that includes the VPC, a subnet, an EC2 instance, and uses the local-exec provisioner to write the EC2 instance’s public IP to a file.

Example main.tf for Terraform:
```
provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# VPC configuration (Assuming you've created the VPC manually)
resource "aws_vpc" "custom_vpc" {
  id = "vpc-xxxxxxxx"  # Replace with your manually created VPC ID
}

# Subnet configuration
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Specify the AZ of your choice
  map_public_ip_on_launch = true
}

# Security group for EC2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow inbound traffic on port 22 (SSH)"
  vpc_id      = aws_vpc.custom_vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}

# EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-xxxxxxxx"  # Use a valid AMI ID for your region
  instance_type = "t2.micro"      # Adjust the instance type as needed
  subnet_id     = aws_subnet.subnet.id
  security_groups = [aws_security_group.ec2_security_group.name]

  # Local-exec provisioner to write IP address to a file
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-ip.txt"
  }

  tags = {
    Name = "TerraformEC2Instance"
  }
}
```

Explanation:
Provider: Specifies the AWS region where resources will be created.
VPC: We reference the manually created VPC by its ID.
Subnet: Creates a subnet within the manually created VPC.
Security Group: A security group allowing inbound SSH (port 22) traffic and unrestricted egress.
EC2 Instance: Creates an EC2 instance inside the subnet with SSH access. The local-exec provisioner runs after the instance is created and writes the EC2 instance’s public IP to a file called ec2-ip.txt in the local working directory.
3. Initialize Terraform
In your project directory, run the following commands:

bash
Copy
terraform init
This initializes the Terraform project and downloads the necessary provider plugins.

4. Apply Terraform Configuration
Now, apply the Terraform configuration to create the resources:

bash
Copy
terraform apply
Terraform will show a plan of what will be created. Confirm the action by typing yes when prompted.

5. Verify EC2 IP in the File
After Terraform has successfully applied the configuration, it will execute the local-exec provisioner and write the EC2 instance's public IP to a file called ec2-ip.txt in your local directory.

You can open the ec2-ip.txt file to verify the IP address of the EC2 instance.

Example output in ec2-ip.txt:
Copy
54.123.45.67
