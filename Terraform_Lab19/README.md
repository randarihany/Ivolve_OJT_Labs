### Lab 19: Terraform Modules
**Objective:**
- Manually create a VPC in your AWS account.
- Create two reusable Terraform modules:
- A Network module to manage a VPC with 2 public subnets, route tables, and an internet gateway.
- A Server module to create an EC2 instance with Nginx installed, a security group, and a dynamically generated key pair.
- Use the Server module twice to create EC2 instances in each subnet.
  
### Architecture:

![image](https://github.com/user-attachments/assets/afaaffbc-1bd7-4ce7-8fe6-327fb71e50e0)

---


- **Step 1: Manually Create a VPC in AWS:**

Provide a name for your VPC (e.g., my-vpc).
Set the IPv4 CIDR block (e.g., 10.0.0.0/16).

Screenshot: Add a screenshot of the VPC creation page in the AWS Management Console showing the VPC details (e.g., name, CIDR block).

![image](https://github.com/user-attachments/assets/29f1fe59-823a-4323-83d2-ecf56a48d909)

![image](https://github.com/user-attachments/assets/6cbb6a28-87b0-4279-bfb0-93207eeb3124)

- **Step 2: Set Up Terraform Directory Structure:**

Create a directory structure for your Terraform project with the following components:

![image](https://github.com/user-attachments/assets/98eefae9-7c94-4c64-9ce2-ba85daa83173)


A root configuration file (main.tf) to define the provider and call the modules.

A modules directory containing:

A Network module to manage the VPC, subnets, and internet gateway.

A Server module to manage EC2 instances, security groups, and key pairs.

Screenshot: Add a screenshot of your directory structure in your code editor or terminal.

Step 3: Create the Network Module
The Network module will create:

2 public subnets

**Output**
![image](https://github.com/user-attachments/assets/cc990a14-631b-4ba4-a724-09e0393a6f1b)

Route tables
![image](https://github.com/user-attachments/assets/1927229a-7b05-440d-9214-f35b235da6c2)

![image](https://github.com/user-attachments/assets/ceefbf10-7a8d-48bd-b07d-f549149cd01e)

An internet gateway

Key Components
Define resources for subnets, internet gateway, and route tables.

Use variables to pass the VPC ID, CIDR block, and availability zones.

Output the subnet IDs for use in the Server module.

Screenshot: Add a screenshot of the AWS Management Console showing the created subnets, route tables, and internet gateway.

Step 4: Create the Server Module
The Server module will create:

A single EC2 instance with Nginx installed

A security group

A dynamically generated key pair

Key Components
Use the tls_private_key resource to generate an SSH key pair.

![image](https://github.com/user-attachments/assets/d268406c-4af5-49ec-a53a-fc4223a52907)


Define a security group to allow HTTP (port 80) and SSH (port 22) traffic.

![image](https://github.com/user-attachments/assets/a88bd12e-092b-4414-8857-2dbb993dbe52)

Use the aws_instance resource to create an EC2 instance with Nginx installed via user data.

![image](https://github.com/user-attachments/assets/ae5b5f8a-3578-4926-b5d3-f96726940810)

Output the instance ID and private key for SSH access.

Screenshot: Add a screenshot of the AWS Management Console showing the created EC2 instances and security groups.

![image](https://github.com/user-attachments/assets/36b232ef-7b17-4361-89c6-6362c098b2c6)

Step 5: Use the Modules in the Root Configuration
In the root configuration:

Define the AWS provider.

Call the Network module to create the VPC resources.

Call the Server module twice to create EC2 instances in each subnet.

Screenshot: Add a screenshot of the terraform plan output showing the resources to be created.

Step 6: Apply the Configuration
Run terraform init to initialize the configuration.
Run terraform plan to review the changes.
Run terraform apply to create the resources.
```
terraform init
terraform [plan
terraform apply
```

Screenshot: Add a screenshot of the terraform apply output showing the resources created.

![image](https://github.com/user-attachments/assets/6f3b311a-1875-4f1f-921b-fd2a46fa27d0)


Step 8: Access the EC2 Instances
Use the private key output from Terraform to SSH into the instances.

Verify that Nginx is running by accessing the public IP of the instances in a web browser.

Screenshot: Add a screenshot of the Nginx welcome page accessed via the EC2 instance's public IP.

## Test connections:

- **Server1**

![image](https://github.com/user-attachments/assets/ae0497f0-4d61-4076-aa83-e407d39025f7)

- **Server2**
- 
![image](https://github.com/user-attachments/assets/e22c2b51-a509-409a-8416-3c1ed5662daf)

