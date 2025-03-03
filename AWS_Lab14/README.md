# Lab 14: SDK and CLI Interactions
• Objective: Use the AWS CLI to Create an S3 bucket, configure permissions, and upload/download files to/from the bucket. Enable versioning and logging for the bucket.


For Lab 14: SDK and CLI Interactions, you'll be using the AWS CLI to interact with Amazon S3 for several tasks. Below are the detailed steps to create an S3 bucket, configure permissions, upload/download files, and enable versioning and logging.

1. Create an S3 Bucket
The first task is to create an S3 bucket using the AWS CLI. The bucket name must be globally unique.

Command:
```
aws s3 mb s3://your-unique-bucket-name
```
Output:
![image](https://github.com/user-attachments/assets/20fbb0dd-7a07-4aa7-8877-6e4e81e4759c)

2. Configure Bucket Permissions
Next, you'll set permissions for your S3 bucket. You can either apply an ACL (Access Control List) or use a bucket policy to manage access.

Example of Granting Public Read Access:
To allow public read access, use this bucket policy:
currently no bucket policy:
![image](https://github.com/user-attachments/assets/5fdbb168-d31b-496f-a66e-22e50ea6af3d)

```
aws s3api put-bucket-policy --bucket your-unique-bucket-name --policy file://policy.json
```
policy.json (Example to allow public read access):

json
``
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

Can pass policy  inline:

![image](https://github.com/user-attachments/assets/e9bc7f07-1075-49dc-b16d-5ee88dc4a251)

3. Enable Versioning
You can enable versioning on your S3 bucket, which will allow S3 to keep multiple versions of an object.

Command:
```
aws s3api put-bucket-versioning --bucket ivolve-lab18 --versioning-configuration Status=Enabled 
```

4. Enable Logging
To enable logging on your S3 bucket, you need to configure a target bucket to store the logs. Let's assume you have another bucket called logs-bucket.
creat logging bucket:
```
aws s3 mb s3://ivolve-logs-bucket 
```
Command to enable logging:
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
- Verify Logging Configuration
```
aws s3api get-bucket-logging --bucket ivolve-lab18
```

![image](https://github.com/user-attachments/assets/7912dd05-99a1-463e-aa6a-a165b023c6a6)

5. Upload a File to the S3 Bucket
Use the AWS CLI to upload files to your S3 bucket. For example, if you want to upload a file called file.txt from your local machine:
```
aws s3 cp file.txt s3://ivolve-lab18/
```
![image](https://github.com/user-attachments/assets/3285a0e8-f632-4543-8dba-51bb163ed859)

-Download File:
This will download file.txt to your current working directory.
```
aws s3 cp s3://ivolve-lab18/file2.txt . 
```

![image](https://github.com/user-attachments/assets/68ec99e2-8df7-45fe-b78e-4390a0b33751)

7. Check the Versioning and Logging Status
To confirm that versioning is enabled and logging is working:

- Check Versioning Status:
```
aws s3api get-bucket-versioning --bucket ivolve-lab18
```

![image](https://github.com/user-attachments/assets/ba657ee9-5418-4fa1-9b15-d05ac0ffd0c7)

- Check Logging Status:
```
aws s3api get-bucket-logging --bucket ivolve-lab18
```

![image](https://github.com/user-attachments/assets/90ed50d1-271a-4c11-8636-cb2e6fbd8a05)

AWS Console:
![image](https://github.com/user-attachments/assets/77304cf0-a7cb-4c5b-a98e-a8e4dc3ddca8)

![image](https://github.com/user-attachments/assets/af88e612-97a8-4aa6-bef4-cf1473f336f1)


