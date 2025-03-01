 # Lab 13: Create AWS Load Balancer
• Objective: create VPC with 2 subnets, launch 2 EC2s with nginx and apache installed, and create and configure a Load Balancer to access the 2 Web servers.

![image](https://github.com/user-attachments/assets/f8ac0a8b-5f30-499d-a3ef-6c3f89f6b9a9)


Step 1: Create a VPC with 2 Public Subnets
Log in to AWS Management Console and go to the VPC dashboard.
Create a new VPC by clicking "Create VPC" and entering the necessary details:
Choose an IPv4 CIDR block, e.g., 10.0.0.0/16.
Name the VPC (e.g., Lab13-VPC).
Create 2 Public Subnets:
In the VPC dashboard, go to Subnets and click "Create subnet."
Choose your VPC and provide a subnet CIDR (e.g., 10.0.1.0/24 for Subnet 1 and 10.0.2.0/24 for Subnet 2).
Ensure that both subnets are in different Availability Zones for high availability.
Check the option to make the subnets public by enabling the "Auto-assign Public IP" option.
Create an Internet Gateway:
Go to Internet Gateways and create one, then attach it to the VPC.
Step 2: Launch EC2 Instances (Web Servers)
Go to EC2 and launch two EC2 instances (one for each subnet).
Use a public Amazon Linux AMI or any other Linux distribution.
For instance type, you can choose t2.micro (eligible for the free tier).
During configuration, place each instance in one of the public subnets.
Assign Elastic IPs or use public IP addresses so they are publicly accessible.
Security Groups:
Allow HTTP (port 80) from anywhere (0.0.0.0/0).
Allow SSH (port 22) for accessing the instances.
Make sure to allow only the load balancer's security group to communicate on port 80 with the EC2 instances (we'll configure this in the next steps).
After launching the EC2 instances, SSH into both instances and install nginx on one and apache on the other:
For Nginx:
bash
Copy
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
For Apache:
bash
Copy
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
Step 3: Create a Security Group for Load Balancer
Go to the Security Groups section and create a new Security Group (e.g., LoadBalancer-SG).
Allow inbound traffic on HTTP (port 80) from anywhere (0.0.0.0/0).
This SG will be used for your Load Balancer.
Step 4: Set Up an Application Load Balancer
Go to the EC2 Dashboard and select Load Balancers under the Load Balancing section.
Click Create Load Balancer and choose Application Load Balancer.
Configure the Load Balancer:
Name: Lab13-ALB
Scheme: internet-facing
IP address type: ipv4
Select 2 Public Subnets (the ones you created earlier).
Configure the Listeners:
Add a listener on HTTP (port 80).
Configure the Security Groups:
Use the LoadBalancer-SG security group created earlier.
Configure Target Group:
Create a new target group and choose Instance as the target type.
Set the protocol to HTTP and port to 80.
Keep the default health check settings for HTTP.
Step 5: Register EC2 Instances with the Load Balancer
After configuring the target group, add your two EC2 instances (the ones running nginx and apache).
Verify the health status of the instances. The Load Balancer should route traffic to them once they pass the health check.
Step 6: Modify Security Groups of EC2 Instances
Modify the Security Groups of the EC2 instances (Web Servers) to accept traffic only from the Load Balancer.
Go to Security Groups and edit the security group associated with your EC2 instances.
Create an inbound rule allowing HTTP (port 80) traffic only from the Load Balancer’s security group.
Remove any other unnecessary inbound rules that might expose the EC2 instances to the internet.
Step 7: Test the Setup
Go to the Load Balancer’s DNS name (you’ll find it in the Load Balancer dashboard).
Open the DNS name in a browser. The load balancer should route requests to the two EC2 instances.
The instance running nginx should serve an Nginx page.
The instance running Apache should serve an Apache page.
