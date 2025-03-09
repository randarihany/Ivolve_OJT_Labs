
### Lab 19: Terraform Modules
Create VPC manually in your AWS account.
Create 2 reusable Terraform modules to manage a VPC and EC2 instance in AWS.
﻿﻿﻿The Network module will include 2 public subnets, route tables, and an internet gateway.
﻿﻿﻿The Server module will create a single EC2 instance with Nginx installed, a security group, and key pair.
• Use the Server module twice to create EC2 instance in each subnet.

## Architecture:
![image](https://github.com/user-attachments/assets/afaaffbc-1bd7-4ce7-8fe6-327fb71e50e0)


## Test connections:

- **Server1**

![image](https://github.com/user-attachments/assets/ae0497f0-4d61-4076-aa83-e407d39025f7)

- **Server2**
- 
![image](https://github.com/user-attachments/assets/e22c2b51-a509-409a-8416-3c1ed5662daf)

