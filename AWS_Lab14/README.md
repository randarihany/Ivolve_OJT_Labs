# Lab 14: SDK and CLI Interactions

## Objective
Use the AWS CLI to:
- Create an S3 bucket.
- Configure permissions.
- Upload and download files to/from the bucket.
- Enable versioning and logging for the bucket.

---

## Steps to complete the lab

### 1. Create an S3 Bucket
Create an S3 bucket using the AWS CLI. (The bucket name must be globally unique)

**Command:**
```
aws s3 mb s3://your-unique-bucket-name
```

**Output:**

![image](https://github.com/user-attachments/assets/20fbb0dd-7a07-4aa7-8877-6e4e81e4759c)

### 2. Configure Bucket Permissions
Example of Granting Public Read Access:

**currently no bucket policy:**

![image](https://github.com/user-attachments/assets/5fdbb168-d31b-496f-a66e-22e50ea6af3d)

To allow public read access, use this bucket policy:

```
aws s3api put-bucket-policy --bucket ivolve-lab18 --policy file://s3_policy.json
```

s3_policy.json:
```
{
  "Version": "2012-10-17",
  "Statement": [
  {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-unique-bucket-name/*"
    }
  ]
}

```
Can either pass policy  inline:

![image](https://github.com/user-attachments/assets/e9bc7f07-1075-49dc-b16d-5ee88dc4a251)

### 3. Enable Versioning
Enable versioning on S3 bucket, which will allow S3 to keep multiple versions of an object.

**Command:**
```
aws s3api put-bucket-versioning --bucket ivolve-lab18 --versioning-configuration Status=Enabled 
```

### 4. Enable Logging
Enable logging on S3 bucket,will need to configure a target bucket to store the logs.
Accordingly will create bucket called ivolve-logs-bucket.

create logging bucket:
```
aws s3 mb s3://ivolve-logs-bucket 
```
**Command:**
```
aws s3api put-bucket-logging --bucket ivolve-lab18 --bucket-logging-status '{
  "LoggingEnabled": {
  "TargetBucket": "ivolve-logs-bucket",
  "TargetPrefix": "log/"
  }
}'
```
TargetBucket: The bucket where logs will be stored.

TargetPrefix: A prefix for the log file (optional).

Verify logging configuration
```
aws s3api get-bucket-logging --bucket ivolve-lab18
```

![image](https://github.com/user-attachments/assets/7912dd05-99a1-463e-aa6a-a165b023c6a6)

### 5. Upload a File to the S3 Bucket
For example, upload a file called file1.txt from local machine.

**Comand:**
```
aws s3 cp file.txt s3://ivolve-lab18/
```
![image](https://github.com/user-attachments/assets/3285a0e8-f632-4543-8dba-51bb163ed859)

### 6. Download a File from the S3 Bucket
For example, download a file called file2.txt to local machine to current working directory.

**Comand:**
```
aws s3 cp s3://ivolve-lab18/file2.txt . 
```

![image](https://github.com/user-attachments/assets/68ec99e2-8df7-45fe-b78e-4390a0b33751)

### 7. Check the Versioning Status
check and confirm that versioning is enabled.

**Comand:**
```
aws s3api get-bucket-versioning --bucket ivolve-lab18
```

![image](https://github.com/user-attachments/assets/ba657ee9-5418-4fa1-9b15-d05ac0ffd0c7)

### 8. Check the logging Status
check and confirm that logging is enabled.

**Comand:**
```
aws s3api get-bucket-logging --bucket ivolve-lab18
```

![image](https://github.com/user-attachments/assets/90ed50d1-271a-4c11-8636-cb2e6fbd8a05)

---

**AWS Console:**

![image](https://github.com/user-attachments/assets/77304cf0-a7cb-4c5b-a98e-a8e4dc3ddca8)


![image](https://github.com/user-attachments/assets/af88e612-97a8-4aa6-bef4-cf1473f336f1)


