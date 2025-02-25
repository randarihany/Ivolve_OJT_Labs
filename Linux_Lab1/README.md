# Setup User with Elevated Permissions for Web Server Installation:

## Objective:
This guide demonstrates how to create a new user, assign it to a specific group, 
and configure the necessary sudo permissions to allow the user to install and manage a web server (nginx in this case) with elevated privileges without requiring a password.

## Steps
- Create a New User:
The first step is to create a new user that will be assigned specific permissions to install and manage the web server.

![image](https://github.com/user-attachments/assets/08b75631-88b5-425c-8ad4-34cd4cb67fb1)

- Confirm User is created:
![image](https://github.com/user-attachments/assets/f1c290fb-95bb-46e2-b190-f5ccdc40d744)

```
sudo useradd user_ivolve
```


