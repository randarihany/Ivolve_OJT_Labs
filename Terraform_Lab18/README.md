### Lab 18: Terraform Variables and Loops
provisioning a dynamic VPC, subnets, security groups, NAT Gateway, and EC2 instances within AWS. 
Additionally, it sets up Nginx on Amazon Linux 2 for both public and private EC2 instances.
The setup is designed to work dynamically and flexibly with customizable configurations for subnets, security groups, and EC2 instances.

Lab 18: Terraform Variables and Loops
﻿﻿Implement the below diagram with Terraform.
﻿﻿Do not repeat code. Use variables.tf and terraform.tfvars files.
﻿﻿Install Nginx using remote provisioner, Apache using user data.
﻿﻿Output public & private IPs of the EC2s.

## Overview
This Terraform configuration automates the creation of the following resources:

VPC: A custom Virtual Private Cloud (VPC) with a configurable CIDR block.
Subnets: Multiple subnets (public and private) spread across multiple availability zones (AZs).
Security Groups: Public and private security groups for controlling traffic.
NAT Gateway: A NAT Gateway in the public subnet to allow internet access for instances in private subnets.
EC2 Instances: EC2 instances in both public and private subnets, configured to install and run Nginx on Amazon Linux 2.

## Architechture:
![image](https://github.com/user-attachments/assets/9b0be5da-d092-4011-98ca-5b630850670d)

## Resource Breakdown
- **VPC and Subnets:**
VPC: A VPC with a CIDR block of 10.0.0.0/16 is created.

![image](https://github.com/user-attachments/assets/95daf1cf-f2f3-4892-9d84-912814df8b78)


Subnets: The configuration dynamically creates two subnets:

Public Subnet (10.0.0.0/24) for instances that need internet access.
Private Subnet (10.0.1.0/24) for instances without direct internet access.
Screenshot Placeholder for VPC and Subnet Creation

![image](https://github.com/user-attachments/assets/6003aa1f-0021-4a2d-97e8-91856260ca05)


Security Groups
Public Security Group (SG): Allows inbound traffic on ports 22 (SSH) and 80 (HTTP) from any IP (0.0.0.0/0).

![image](https://github.com/user-attachments/assets/c42e7c68-0ec7-4abc-88c7-2bcc4ec2575f)


Private Security Group (SG): Allows inbound traffic on ports 22 (SSH) and 80 (HTTP) from the Public Security Group only.

![image](https://github.com/user-attachments/assets/1fdb50fe-534d-4ea3-a2b0-597773794d41)


Screenshot Placeholder for Security Group Creation

NAT Gateway
NAT Gateway: Deployed in the public subnet with an Elastic IP (EIP) attached. The NAT Gateway allows instances in the private subnet to access the internet through the public subnet.

Screenshot Placeholder for NAT Gateway Creation

![image](https://github.com/user-attachments/assets/4742634d-5dad-4318-bb47-43f2a698b341)


EC2 Instances
Public EC2 Instance: Launched in the public subnet with a public IP and Nginx installed using a user data script.

![image](https://github.com/user-attachments/assets/ab759ba3-7604-496a-aa01-c336f4898772)

Nginx installed using userdata:

![image](https://github.com/user-attachments/assets/0cc515e9-b6ea-43cc-82ba-a4bd65d1bb28)

Private EC2 Instance: Launched in the private subnet, without a public IP, and Nginx installed using a user data script.

![image](https://github.com/user-attachments/assets/8b143116-4e16-4548-8222-3a47e25f7fc3)

Outputs
After the resources are created, Terraform will output the following details:

Public EC2 Instance Public IP: The public IP address of the public EC2 instance.
Public EC2 Instance Private IP: The private IP address of the public EC2 instance.
Private EC2 Instance Private IP: The private IP address of the private EC2 instance.


## Output:
![image](https://github.com/user-attachments/assets/1f930a5f-c066-4a78-95ae-bdc67271d402)
