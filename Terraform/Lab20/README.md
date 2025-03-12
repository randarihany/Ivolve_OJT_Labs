add new inbounnd rule:
![image](https://github.com/user-attachments/assets/d02e377b-7cc6-4ef1-9cf0-92a95f5098fe)

ec2 instance created:
![image](https://github.com/user-attachments/assets/12db5de5-e85e-4549-80c4-e1b947851b94)

login using private key:
![image](https://github.com/user-attachments/assets/cd5a3c9d-4ddc-4b2f-aa82-a6c2623abcbf)

**Instal Jenkins:**

```
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo dnf install java-17-amazon-corretto-devel
sudo yum install jenkins -y
sudo systemctl daemon-reload
```

**Confirmation:**

![image](https://github.com/user-attachments/assets/55ed210f-e912-4537-9be2-1d041b3c0aa0)

**Start Jenkins:**

![image](https://github.com/user-attachments/assets/52949056-4fe0-49a8-b174-be599981baa6)


**Add new inbound rule:**

![image](https://github.com/user-attachments/assets/8005981d-fd80-440c-a85f-43593eb19f41)

**Unlocking Jenkins:**

- Browse to http://localhost:8080 

![image](https://github.com/user-attachments/assets/31da589d-575e-46db-801d-7c49ff44f6a0)


```
sudo more /var/lib/jenkins/secrets/initialAdminPassword
```

**Install Sugested plugins**

![image](https://github.com/user-attachments/assets/e05695d3-ce0d-43ea-a5a4-82dcd870cf1f)


**Jenkins is ready:**
![image](https://github.com/user-attachments/assets/2abb0a25-f1fd-4398-84b8-12d23818520a)

