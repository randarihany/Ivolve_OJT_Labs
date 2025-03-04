# Lab 13: Create AWS Load Balancer

## Objective
- Create a VPC with 2 public subnets.
- Launch 2 EC2 instances with Nginx and Apache installed.
- Create and configure a Load Balancer to access the 2 web servers.

![Lab Overview](https://github.com/user-attachments/assets/f8ac0a8b-5f30-499d-a3ef-6c3f89f6b9a9)

---

## Steps to Complete the Lab

### Step 1: Create a VPC with 2 Public Subnets
1. Log in to the **AWS Management Console** and go to the **VPC Dashboard**.
2. Create a new VPC:
   - Click **Create VPC**.
   - Enter the following details:
     - **IPv4 CIDR block**: `10.0.0.0/16`
     - **Name**: `Lab13-VPC`
   - Click **Create VPC**.

**Output:**
![VPC Created](https://github.com/user-attachments/assets/542b6311-0f25-4b4c-8c98-91ffc3024746)

3. Create 2 Public Subnets:
   - Go to **Subnets** and click **Create subnet**.
   - Configure the following for each subnet:
     - **Subnet 1**:
       - **CIDR block**: `10.0.1.0/24`
       - **Availability Zone**: Choose any AZ.
       - **Auto-assign Public IP**: Enable.
     - **Subnet 2**:
       - **CIDR block**: `10.0.2.0/24`
       - **Availability Zone**: Choose a different AZ.
       - **Auto-assign Public IP**: Enable.
   - Click **Create subnet**.

**Output:**
![Subnets Created](https://github.com/user-attachments/assets/16897416-5df2-4a48-87d7-9595dbc6d3f5)

4. Create an Internet Gateway:
   - Go to **Internet Gateways** and click **Create internet gateway**.
   - Name it `Lab13-IGW`.
   - Attach it to your VPC.

**Output:**
![Internet Gateway](https://github.com/user-attachments/assets/25ea0c73-a7e8-4308-9179-d7df98b45726)

---

### Step 2: Launch EC2 Instances (Web Servers)
1. Go to the **EC2 Dashboard** and launch two EC2 instances:
   - Use a public **Amazon Linux AMI**.
   - Choose `t2.micro` as the instance type.
   - Place each instance in one of the public subnets.
   - Assign Elastic IPs or use public IPs for accessibility.

**Output:**
![EC2 Instances Launched](https://github.com/user-attachments/assets/27dae9d1-74cf-401d-937c-0176acf5acff)

2. Configure Security Groups:
   - Allow **HTTP (port 80)** from anywhere (`0.0.0.0/0`).
   - Allow **SSH (port 22)** for accessing the instances.

3. Install Web Servers:
   - SSH into the first instance and install **Nginx**:
     ```bash
     sudo yum install -y nginx
     sudo systemctl start nginx
     sudo systemctl enable nginx
     ```
   - SSH into the second instance and install **Apache**:
     ```bash
     sudo yum install -y httpd
     sudo systemctl start httpd
     sudo systemctl enable httpd
     ```

---

### Step 3: Create a Security Group for the Load Balancer
1. Go to **Security Groups** and create a new group (`LoadBalancer-SG`).
2. Allow inbound traffic on **HTTP (port 80)** from anywhere (`0.0.0.0/0`).

**Output:**
![Load Balancer Security Group](https://github.com/user-attachments/assets/899f45fa-b701-41b7-b57d-6e70b81bc2b1)

---

### Step 4: Set Up an Application Load Balancer
1. Go to the **EC2 Dashboard** and select **Load Balancers** under the **Load Balancing** section.
2. Click **Create Load Balancer** and choose **Application Load Balancer**.
3. Configure the Load Balancer:
   - **Name**: `Lab13-ALB`
   - **Scheme**: Internet-facing
   - **IP address type**: IPv4
   - **Listeners**: Add a listener on **HTTP (port 80)**.
   - **Subnets**: Select the 2 public subnets created earlier.
   - **Security Groups**: Use `LoadBalancer-SG`.

**Output:**
![Load Balancer Configuration](https://github.com/user-attachments/assets/055cba3b-6207-45e7-a297-e374c56f1c6a)

4. Configure Target Group:
   - Create a new target group (`Lab13-TG`).
   - Set the protocol to **HTTP** and port to `80`.
   - Add the two EC2 instances to the target group.

**Output:**
![Target Group Configuration](https://github.com/user-attachments/assets/0fc0c8aa-88e7-47c9-8dde-bf47fb94cc94)

---

### Step 5: Modify Security Groups of EC2 Instances
1. Go to **Security Groups** and edit the security group associated with your EC2 instances.
2. Add an inbound rule to allow **HTTP (port 80)** traffic only from the Load Balancer’s security group.

**Output:**
![EC2 Security Group](https://github.com/user-attachments/assets/ccfe2dc9-d827-42e5-a50a-e6195659192a)

---

### Step 6: Test the Setup
1. Go to the Load Balancer’s **DNS name** (found in the Load Balancer dashboard).
2. Open the DNS name in a browser:
   - The Load Balancer will route requests to the two EC2 instances.
   - The instance running **Nginx** will serve an Nginx page.
   - The instance running **Apache** will serve an Apache page.

**Output:**
- **Nginx Page**:
  ![Nginx Page](https://github.com/user-attachments/assets/0be636d3-bc46-4329-b44a-0fbf9543468f)
- **Apache Page**:
  ![Apache Page](https://github.com/user-attachments/assets/0b8c3cc2-2249-4daa-9f7e-0f7cc64bd633)
