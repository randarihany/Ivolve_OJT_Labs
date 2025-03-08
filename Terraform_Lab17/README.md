Lab 17: Remote Backend and LifeCycles Rules
Implement the below diagram with Terraform.
Install NGINX using user data.
Store state file in a remote backend (S3).
Use create_before_destroy Lifecycle on the EC2 and verify it.
Compare between different Lifecycles Rules.

# Architecture:
![arch17](https://github.com/user-attachments/assets/fecb3f52-c1ac-43e6-9120-066745101934)

- **Alert Created:**

![image](https://github.com/user-attachments/assets/b16f17ba-7c1d-4674-b076-dcc491de7c39)


- **1. Verify NGINX Installation and access:**
  
![image](https://github.com/user-attachments/assets/773f62fc-19dc-4744-8fd6-c5eed703fcce)

- **2. Verify SNS Email Subscription:**

![image](https://github.com/user-attachments/assets/19be25fb-c12d-4600-8966-9f168952abbc)

- **3. Trigger High CPU Usage to Test CloudWatch Alarm:**
  
Install Stress Tool:

Install the stress tool to simulate CPU load:

```
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
stress --cpu 2 --timeout 300  # create cpu load
```
-  CloudWatch Alarm clearing that CPU exceeded 70%:
![image](https://github.com/user-attachments/assets/69c633f8-1a06-438c-8324-d09ca7a25a9b)

- Email Notification:
![image](https://github.com/user-attachments/assets/e827e9d6-2cb8-4efd-8532-9f4e7663c5b8)


**4. Verify create_before_destroy Lifecycle Rule:**

- Modify the EC2 Instance API so it will need tp be replaced:
  
![image](https://github.com/user-attachments/assets/f9cb99af-6593-4970-9678-508965c6cfd8)


![image](https://github.com/user-attachments/assets/5d18dbcf-c8c2-46db-9c35-9bcc116314e4)

![image](https://github.com/user-attachments/assets/a949136c-9df1-4e3c-8c63-33f31b3c73de)









