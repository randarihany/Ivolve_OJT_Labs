# Lab 5: SSH Configurations
Objective: Generate public and private keys and enable SSH from your machine to another VM using the key. 
Configure SSH to just run 'ssh ivolve' without specify username, IP and key in the command

instance 1   172.31.81.68
instance 2   172.31.90.251


Step 1: Generate SSH Keys
First, we need to generate the SSH key pair (public and private keys). You can use the ssh-keygen command on your local machine:

Open a terminal.

Run the following command to generate the SSH key pair:

```
ssh-keygen
```
Explanation:

-t rsa specifies the type of key (RSA).
-b 2048 specifies the number of bits (2048 is a common and secure choice).
-f ~/.ssh/id_rsa specifies the location and name of the private key file.
It will ask for a passphrase (you can leave it empty if you don't want a passphrase, or enter one for extra security).

Once the key generation is complete, your private key will be located at ~/.ssh/id_rsa and your public key at ~/.ssh/id_rsa.pub.

Step 2: Copy the Public Key to the VM
Next, you need to copy the public key to the remote VM to enable passwordless SSH login.

You can do this using the ssh-copy-id command. For example:

```
ssh-copy-id -i ~/.ssh/id_rsa.pub username@remote_ip
```
Explanation:

-i ~/.ssh/id_rsa.pub specifies the public key file to copy.
username@remote_ip should be replaced with the actual username and IP address of your remote VM.
After running the above command, you’ll be asked to enter the password of the remote machine for the username.

Step 3: Test SSH Login
Now that you’ve copied the public key to the remote VM, you can test if the SSH login works without a password prompt:

```
ssh username@remote_ip
```
If successful, you should be logged in to the remote machine without entering a password.

Step 4: Configure SSH Config File for Shortened Command
To make it so that you only need to type ssh ivolve instead of specifying the username, IP address, and key every time, you’ll need to edit the SSH configuration file.

Open (or create if it doesn't exist) the ~/.ssh/config file in your preferred text editor:

```
nano ~/.ssh/config
```
Add the following configuration for the remote machine:

```
Host ivolve
    HostName remote_ip
    User username
    IdentityFile ~/.ssh/id_rsa
```

Explanation:
Host ivolve: This is the alias you'll use for the SSH connection (i.e., ssh ivolve).
HostName remote_ip: Replace remote_ip with the actual IP address or hostname of the remote VM.
User username: Replace username with the actual username on the remote machine.
IdentityFile ~/.ssh/id_rsa: Specifies the private key file to use.
Save and exit the text editor (for nano, press CTRL + X, then Y to confirm saving, and press Enter).

Step 5: Test the SSH Command
Now, you should be able to connect to the remote VM by simply typing:

```
ssh ivolve
```
This will use the configuration in the ~/.ssh/config file to connect without needing to specify the username, IP, or key explicitly.
