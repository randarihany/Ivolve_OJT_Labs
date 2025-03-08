### Lab 18: Terraform Variables and Loops
Provision a dynamic AWS infrastructure using Terraform. 

The infrastructure will include the following resources:

- VPC
- Subnets
- Security Groups
- NAT Gateway
- EC2 Instances
Additionally, Nginx and Apache will be installed on Amazon Linux 2 EC2 instances within both public and private subnets.

The infrastructure is designed to be flexible and scalable, with configurable variables for subnets, security groups, and EC2 instances, making it adaptable to various use cases.

**Objectives:**
- Implement the infrastructure as per the provided diagram using Terraform.
- Avoid code repetition by utilizing variables.tf and terraform.tfvars files.
- Use a remote provisioner to install Nginx and a user data script to install Apache.
- Output the public and private IPs of the EC2 instances.
- 
## Architechture:

![image](https://github.com/user-attachments/assets/9b0be5da-d092-4011-98ca-5b630850670d)

## Resource Breakdown
- **VPC and Subnets**
**VPC:**
A VPC with a CIDR block of 10.0.0.0/16 is created.

![image](https://github.com/user-attachments/assets/95daf1cf-f2f3-4892-9d84-912814df8b78)


- **Subnets:**
The configuration dynamically creates two subnets:

Public Subnet (10.0.0.0/24) for instances that need internet access.
Private Subnet (10.0.1.0/24) for instances without direct internet access.

![image](https://github.com/user-attachments/assets/6003aa1f-0021-4a2d-97e8-91856260ca05)

- **Security Groups**
**Public Security Group (SG):**
Allows inbound traffic on ports 22 (SSH) and 80 (HTTP) from any IP (0.0.0.0/0).

![image](https://github.com/user-attachments/assets/c42e7c68-0ec7-4abc-88c7-2bcc4ec2575f)

**Private Security Group (SG):**
Allows inbound traffic on ports 22 (SSH) and 80 (HTTP) from the Public Security Group only.

![image](https://github.com/user-attachments/assets/1fdb50fe-534d-4ea3-a2b0-597773794d41)


- **NAT Gateway**
Deployed in the public subnet with an Elastic IP (EIP) attached.
The NAT Gateway allows instances in the private subnet to access the internet through the public subnet.

![image](https://github.com/user-attachments/assets/4742634d-5dad-4318-bb47-43f2a698b341)

-**EC2 Instances**
**Public EC2 Instance:**
Launched in the public subnet with a public IP and Nginx installed using remote provisioner.

![image](https://github.com/user-attachments/assets/ab759ba3-7604-496a-aa01-c336f4898772)

**Nginx installed:**

![image](https://github.com/user-attachments/assets/0cc515e9-b6ea-43cc-82ba-a4bd65d1bb28)

**Private EC2 Instance:**
Launched in the private subnet, without a public IP, and Apache installed using a user data script.

![image](https://github.com/user-attachments/assets/8b143116-4e16-4548-8222-3a47e25f7fc3)

-**Outputs:**
After the resources are created, Terraform will output the following details:

- The public IP address of the public EC2 instance.
- The private IP address of the public EC2 instance.
- The private IP address of the private EC2 instance.

![image](https://github.com/user-attachments/assets/ffc540f6-6e02-475b-83cc-40d35e769c33)

## Output:
![image](https://github.com/user-attachments/assets/1f930a5f-c066-4a78-95ae-bdc67271d402)
