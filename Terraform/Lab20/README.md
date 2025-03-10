Lab 20:
Jenkins installation:
Install and configure Jenkins as a service
Install Jenkins:
```
sudo apt update
sudo apt install openjdk-11-jdk
sudo wget -q -O - https://pkg.jenkins.io/keys/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian/ stable main > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins
```

![image](https://github.com/user-attachments/assets/b316b74e-d71b-4aa6-9794-dd1511359a24)

![Uploading image.png…]()
