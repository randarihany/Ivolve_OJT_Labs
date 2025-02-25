# Setup User with Elevated Permissions for Web Server Installation:

## Objective:
This guide demonstrates how to create a new user, assign it to a specific group, 
and configure the necessary sudo permissions to allow the user to install and manage a web server (nginx in this case) with elevated privileges without requiring a password.

## Steps
- Create a New User:
The first step is to create a new user that will be assigned specific permissions to install and manage the web server.

```
sudo useradd user_ivolve
tail -n 1 /etc/passwd
```

- Confirm User is created:
![image](https://github.com/user-attachments/assets/19c34b34-9fa8-4809-bcf6-9743717e3424)

- Create a New Group and Assign the User to group:
We will create a group called group_ivolve and add the new user to this group, which will be used to grant specific permissions later.
1. To create the new group, run the following command:
```
sudo groupadd group_ivolve
tail -n 1 /etc/groups
```
2. Confirm group is created:
![image](https://github.com/user-attachments/assets/cf8c7d6b-03bb-4da4-881e-1cfe9f6a884f)

3.To add the user ivolve_user to the ivolve_group group, use the following command:

```
sudo usermod -aG group_ivolve ivolve_user
```
4. Verify the Group Membership: To confirm that the user has been successfully added to the group, run the following command:

```
sudo groups user_ivolve
```
You should see ivolve_group listed in the output, indicating the user is part of the group.

# Configure Sudo Permissions
we will configure the sudo permissions to allow members of ivolve_group to install a web server (nginx) without a password.

1. Create a Configuration File for Sudoers: We will create a custom configuration file for the ivolve_group inside /etc/sudoers.d/. This will define the necessary sudo permissions.

To create and edit the configuration file, run:
Add the Required Permissions: In the file, add the following lines to allow members of the ivolve_group to run the necessary commands without a password:

```
cd /etc/sudoers.d
sudo echo "%ivolve_group ALL=(ALL) NOPASSWD:/usr/bin/apt install nginx , /usr/bin/apt run nginx" >> /etc/sudoers.d/ivolve
```

Explanation:

- %group_ivolve: This applies the rule to any user in the ivolve_group.
- ALL: The rule applies to all machines.
- (ALL): This allows users to run commands as any user.
- NOPASSWD:: This specifies that users in the group do not need to provide a password when running the listed commands.
- /usr/bin/apt install nginx, /usr/bin/apt run nginx: These are the commands that can be run without a password prompt. You can adjust the commands as necessary.

2. Set the Correct Permissions for the File: Ensure the file has the correct permissions so it can be read by sudoers and is secure:

```
sudo chmod 0440 /etc/sudoers.d/ivolve
```
This ensures that the file is readable but not writable by non-root users.

# Test the Configuration
Test for the New User (user)ivolve)
1. Log in as ivolve_user or switch to the user using:
```
su - user_ivolve
```
2.Test the sudo commands to ensure that ivolve_user can install and run nginx without a password prompt:
```
sudo apt install nginx
sudo apt run nginx
```

If the configuration is correct, the commands will run without prompting for a password.

# Additional Notes:
-Why Use /etc/sudoers.d/?: Adding configurations to /etc/sudoers.d/ is a modular way to manage sudo permissions, making it easier to keep track of changes for specific users or groups.
-Security Considerations: Always ensure that only trusted users are added to the ivolve_group, as they will have elevated privileges to install and manage software with sudo.
-sudoers Syntax: If there are syntax errors in the /etc/sudoers or /etc/sudoers.d/ files, the system may lock you out of sudo functionality. Always use visudo to edit these files, as it checks the syntax before saving.











