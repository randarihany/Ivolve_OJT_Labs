# Lab 16: Multi-Tier Application Deployment with Terraform

## Objective
- Create a VPC manually.
- Use Terraform to manage this VPC.
- Implement the architecture shown below using Terraform.
- Use a local provisioner to write the EC2 instance's IP address to a file called `ec2-ip.txt`.

---

## Architecture
![Architecture Diagram](https://github.com/user-attachments/assets/d2e8c610-379e-4f4d-bdb1-a231a0ee94de)

---

## Steps to Complete the Lab

### Step 1: Create a VPC Manually
- **VPC only** option (without additional resources).
- Configure the VPC with the following settings:
   - **IPv4 CIDR Block**: `10.0.0.0/16`
   - **Tenancy**: Default

**VPC Configurations:**
![VPC Configuration](https://github.com/user-attachments/assets/16666fde-6ca0-4007-b0fd-4e7f7ad3c9bb)

**VPC Outputs:**
![VPC Output](https://github.com/user-attachments/assets/b3f79f71-0f61-40e7-97b2-65ee34d875dc)

---

### Step 2: Import the VPC into Terraform
1. Initialize Terraform:
```
terraform init
```
2.Import the manually created VPC into Terraform:

```
terraform import aws_vpc.main vpc-0c2d15a417e3da752
```

**Import Result:**

![image](https://github.com/user-attachments/assets/3c0b9051-2726-459f-9a29-c240c9d553eb)

### Step 3: Set Up Terraform Configuration:
- [Go to]Terraform_Lab16/code

- That includes:
  - Provider: Specifies the AWS region where resources will be created.
  - VPC: We reference the manually created VPC by its ID.
  - Subnet: Creates a subnet within the manually created VPC.
  - EC2 Instance: Creates an EC2 instance inside the subnet with SSH access. The local-exec provisioner runs after the instance is created and writes the EC2 instance’s public 
    IP to a file called ec2-ip.txt in the local working directory.
### Step 4: Initialize and Apply Terraform Configuration:

- Initialize Terraform:

```
terraform init
terraform apply
```

### Step 5: Verify the EC2 IP in the File

After Terraform has successfully applied the configuration, it will execute the local-exec provisioner and write the EC2 instance's public IP to a file called ec2-ip.txt in your local directory.

You can open the ec2-ip.txt file to verify the IP address of the EC2 instance.

![image](https://github.com/user-attachments/assets/05140150-2088-44c5-91b7-b014fa867dbe)

![image](https://github.com/user-attachments/assets/84761971-de79-4b08-8a45-daaa15dab9ed)


Terraform Ec2:
![image](https://github.com/user-attachments/assets/dbf1bcf4-7c9f-4435-b323-8e8b761ebabc)
- 

![image](https://github.com/user-attachments/assets/b25d7f74-3f57-4f6c-9555-8c5e1519cbb7)
-

![image](https://github.com/user-attachments/assets/aba39251-44f3-42a2-b7cc-8777d271bcc7)
-
![image](https://github.com/user-attachments/assets/b59f8794-414a-4bc5-a9b1-a44d86e479bc)

- EC2 Instance
- 
![image](https://github.com/user-attachments/assets/a92bd3a1-e82b-46ed-9cb1-869ae66d6fa5)





