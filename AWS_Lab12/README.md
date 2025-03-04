# Lab 12: Launching an EC2 Instance with a Bastion Host

## Architecture:
![Lab Overview](https://github.com/user-attachments/assets/71793f42-fbab-46e5-a0c6-aaa438a3acb8)

---

## Objective
- Create a Virtual Private Cloud (VPC) with both public and private subnets.
- Launch an EC2 instance in each subnet (one in the public subnet and one in the private subnet).
- Configure security groups to allow only inbound SSH traffic from the public EC2 instance to the private EC2 instance.
- Use the public EC2 instance (bastion host) to SSH into the private EC2 instance.

---

## Steps to Complete the Lab

### Step 1: Create a VPC
- Configure VPC with the following settings:
   - **VPC Name**: `Main_VPC`
   - **IPv4 CIDR block**: `10.0.0.0/16`
   - **IPv6 CIDR block**: No IPv6
   - **Tenancy**: Default


**AWS Console:**

![VPC Created](https://github.com/user-attachments/assets/aa113018-aa41-4362-a1a8-3d347e04ada0)

---

### Step 2: Create Subnets
Create one public subnet and one private subnet within the VPC.

#### Public Subnet:
- Configure subnet with the following settings:
   - **VPC**: Select your newly created VPC.
   - **Subnet Name**: `PublicSubnet`
   - **Availability Zone**: Choose any available AZ.
   - **IPv4 CIDR block**: `10.0.1.0/24`
   - **Auto-assign Public IP**: Enable.

**AWS Console:**

![Public Subnet](https://github.com/user-attachments/assets/5467792a-5910-4c13-8e15-b764851d0792)

#### Private Subnet:
- Configure the following settings:
   - **VPC**: Select your VPC.
   - **Subnet Name**: `PrivateSubnet`
   - **Availability Zone**: Choose any available AZ.
   - **IPv4 CIDR block**: `10.0.2.0/24`

**Output:**

![Private Subnet](https://github.com/user-attachments/assets/7092380f-2a34-41ef-bc8c-977186b7bccf)

**Subnet Output:**

![Subnets Overview](https://github.com/user-attachments/assets/57718f58-d58c-451c-9fdf-181401317995)

---

### Step 3: Set Up an Internet Gateway
- Go to **Internet Gateways** in the VPC dashboard.
- Name  `MyInternetGateway`.
- Attach the internet gateway to  VPC

**AWS Console:**

![Internet Gateway](https://github.com/user-attachments/assets/a65c720b-1da7-4fbd-8aca-2ae44bf39803)

![Attach Internet Gateway](https://github.com/user-attachments/assets/96946800-e8bd-4bc6-adf1-43fd89dd9f74)

---

### Step 4: Route Tables Configuration

#### Public Subnet Route Table
- **Main Route Table** and click **Edit routes**.
- Add a route to allow outbound internet traffic:
   - **Destination**: `0.0.0.0/0`
   - **Target**: Select your Internet Gateway.

**AWS Console:**

![Public Route Table](https://github.com/user-attachments/assets/56ff9a8c-0050-43fe-a6d5-ed9ffb1b38b5)

- Associate the route table with the **PublicSubnet**:

**AWS Console:**

![Associate Subnet](https://github.com/user-attachments/assets/0edf40ed-dc4a-44aa-a471-fe50596d5dce)

#### Private Subnet Route Table
- Create a new route table for the private subnet:
   - **Route Tables** and click **Create route table**.
   - Name  `PrivateRouteTable`.

**AWS Console:**

![Private Route Table](https://github.com/user-attachments/assets/e630cdb3-c0cd-444a-a144-6222662d5c1a)

- Associate the route table with the **PrivateSubnet**:
  
**AWS Console:**
  
 ![Associate Private Subnet](https://github.com/user-attachments/assets/84ec96cf-4289-49aa-9a2c-a3d1452d744d)

---

### Step 5: Launch EC2 Instances

#### Launch Public EC2 Instance (Bastion Host)
- **Launch Instance**.
- **Amazon Linux AMI**.
- instance type (e.g., `t2.micro`).
- Configure the instance to be in the **PublicSubnet**.

**AWS Console:**
![Public Instance Configuration](https://github.com/user-attachments/assets/a3076042-072c-4d86-81f2-9c147a1f3259)

- In the **Configure Security Group**, create a new security group (`PublicSecurityGroup`) with the following rules:
   - **Type**: SSH
   - **Source**: `0.0.0.0/0` (or your IP for limited access).
- Launch the instance and download the private key (`.pem` file).

**AWS Console:**

![Public Instance Launched](https://github.com/user-attachments/assets/0a7c4be6-d91c-47ff-b2eb-5313dd267eef)

#### Launch Private EC2 Instance
- Launch a second EC2 instance in the **PrivateSubnet** with the same AMI and instance type as the public instance.
- In the **Configure Security Group**, create a new security group (`PrivateSecurityGroup`) with the following rules:
   - **Type**: SSH
   - **Source**: Custom IP (select the public EC2 instance's security group).
- Launch the instance and download its private key.
- 
**AWS Console:**
  
![image](https://github.com/user-attachments/assets/910bd597-0a70-4432-8776-e96aae5ff9b9)

---

### Step 6:Test Set Up SSH Access via the Bastion Host
- From local machine, SSH into the public EC2 instance using its public IP and the downloaded `.pem` key:
```
ssh -i public-key.pem ec2-user@<Public-EC2-Public-IP>
```

- From the public EC2 instance (the bastion host), SSH into the private EC2 instance using its private IP:

![image](https://github.com/user-attachments/assets/d1004986-090b-4169-a79f-289282863db8)

- From Bastion Host:

![image](https://github.com/user-attachments/assets/98da269c-11f8-46fd-aaeb-5415a358a57d)
