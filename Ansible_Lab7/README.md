# Lab 7: Ansible Playbooks for Web Server Configuration
• Objective: Write an Ansible playbook to automate the configuration of a web server.


Key Tasks:
Update Package Cache: Updates the apt package manager cache to ensure all packages are up to date.
Install Apache2: Installs the Apache HTTP server if it's not already installed.
Ensure Apache2 is Started and Enabled: Starts Apache and ensures it is enabled to start on boot.
Copy a Custom Index.html: Copies a custom index.html file from your local machine to the server's web directory.
Open Firewall for Apache: Allows traffic on the default Apache port (80, 443) using the ufw firewall.
Restart Apache: Restarts Apache to ensure any changes are applied.

```
mkdir ansible
vim webserver.yml
```

```
---
- name: Install and start Apache HTTPD
  hosts: web
  tasks:
    - name: Install Apache 
      ansible.builtin.dnf:
        name: httpd
        state: present

    - name: Correct index.html is present
      ansible.builtin.copy:
        src: files/index.html
        dest: /var/www/html/index.html

    - name: Ensure httpd is started, if not started
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: true
```
check playbook syntax
```
ansible-navigator run -m stdout /ansible/webserver_installation.yml --syntax-check
```
Before running:
Apache not installed:
![image](https://github.com/user-attachments/assets/8a5d98dd-ebfc-4d75-bdca-aaad4d08e662)

Run playbook
```
ansible-navigator run -m stdout /ansible/webserver_installation.yml
```


