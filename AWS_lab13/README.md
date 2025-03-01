 # Lab 13: Create AWS Load Balancer
• Objective: create VPC with 2 subnets, launch 2 EC2s with nginx and apache installed, and create and configure a Load Balancer to access the 2 Web servers.

![image](https://github.com/user-attachments/assets/f8ac0a8b-5f30-499d-a3ef-6c3f89f6b9a9)


Step 1: Set up the VPC
Log in to the AWS Console:

Go to the AWS Management Console.
Create a VPC:

Navigate to the VPC Dashboard.
Click on Create VPC.
Name: Enter a name for the VPC (e.g., LabVPC).
IPv4 CIDR Block: Choose a CIDR block (e.g., 10.0.0.0/16).
Tenancy: Default (you can leave this as is).
Click Create.
Create Subnets:

After creating the VPC, create two subnets in different Availability Zones for high availability.
Go to the Subnets section and click on Create subnet.
Subnet 1:
Name: Subnet-1
VPC: Select the VPC you just created.
Availability Zone: Choose one (e.g., us-east-1a).
CIDR Block: 10.0.1.0/24.
Subnet 2:
Name: Subnet-2
VPC: Select the VPC you created.
Availability Zone: Choose another zone (e.g., us-east-1b).
CIDR Block: 10.0.2.0/24.
Click Create for both subnets.
Create an Internet Gateway:

Go to the Internet Gateways section in the VPC Dashboard.
Click Create internet gateway.
Name it Lab-Internet-Gateway.
Click Create and then attach the Internet Gateway to your VPC.
Update the Route Table:

Go to Route Tables and find the route table for your VPC.
Click Edit Routes, then Add Route:
Destination: 0.0.0.0/0
Target: Select your Internet Gateway.
Click Save Routes.
Step 2: Launch EC2 Instances (with Nginx and Apache)
Launch the First EC2 Instance:

Go to EC2 Dashboard and click Launch Instance.
AMI: Choose an Amazon Linux 2 AMI (or any Linux-based AMI).
Instance Type: Choose a free-tier eligible instance type (e.g., t2.micro).
Configure Instance: Ensure the instance is launched in the Subnet-1.
Add Storage: Leave the default settings.
Configure Security Group: Create a new security group or select an existing one. Allow HTTP (port 80), HTTPS (port 443), and SSH (port 22) for your IP.
Key Pair: Select an existing key pair or create a new one.
Launch the instance.
Connect to the EC2 Instance:

SSH into the EC2 instance using the public IP and key pair.
Install Nginx on EC2 Instance:

bash
Copy
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
Launch the Second EC2 Instance:

Repeat the above steps to launch a second EC2 instance in Subnet-2 and install Nginx and Apache (or Nginx alone, depending on the requirement).
Install Apache with the following command:
bash
Copy
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
Step 3: Create an AWS Load Balancer
Go to the Load Balancer Section:

In the AWS Console, navigate to EC2 > Load Balancers.
Click Create Load Balancer.
Select Load Balancer Type:

Choose the Application Load Balancer (for HTTP/HTTPS traffic).
Configure Load Balancer:

Name: Give your load balancer a name (e.g., WebServerLB).
Scheme: Choose internet-facing.
IP address type: Choose ipv4.
Listeners: By default, HTTP (port 80) is selected, which is fine for now.
Availability Zones: Select the VPC you created and select both subnets (Subnet-1 and Subnet-2).
Configure Security Group:

Create a new security group that allows inbound HTTP (port 80) and HTTPS (port 443).
Configure Routing:

Target group name: Create a new target group (e.g., WebServerTargets).
Target type: Choose Instance.
Protocol: HTTP.
Port: 80 (or 443 if you set up SSL).
Health checks: The default health check path (/) should work if you're running a basic web server.
Register Targets (EC2 Instances):

After the load balancer is created, register both EC2 instances with the load balancer.
Select the two EC2 instances you launched earlier and add them to the target group.
Review and Create the Load Balancer:

Review all settings and click Create.
Step 4: Test the Setup
Get the Load Balancer's DNS Name:

Once the load balancer is created, you'll be provided with a DNS name (e.g., webserverlb-1234567890.us-west-1.elb.amazonaws.com).
Access the Load Balancer:

Open a web browser and enter the load balancer's DNS name.
You should see the content served by one of your EC2 instances (the one that was first chosen for health checks).
Verify Load Balancer Routing:

Refresh the page a few times to verify that the load balancer is alternating between your EC2 instances.
