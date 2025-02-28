#IP Range Ping Script

#Description
This bash script loops through a specified IP range (from 192.168.227.0 to 192.168.227.255) and pings each IP address in the range to check whether the server is reachable. The script will output the status of each server, indicating whether it is "up and running" or "unreachable."

#Features
Pings each IP address in the 192.168.227.0/24 subnet.
Uses a 1-second timeout for each ping attempt.
Suppresses the output of the ping command to keep the terminal clean.
Provides feedback for each IP address, indicating whether the server is reachable or not.

2. Make the Script Executable
```
Before running the script, you need to make it executable. Run the following command:
chmod +x ping_range.sh
```

![image](https://github.com/user-attachments/assets/e5b3400b-036d-436b-86dc-5cb97f00fb28)


3. Run the Script
Once the script is executable, you can run it by executing:
```
./ping_range.sh
```

4. Script Output
The script will output the status of each server in the specified IP range (192.168.227.0 to 192.168.227.255). For example:
![image](https://github.com/user-attachments/assets/0689ef82-d2af-4bd3-8eda-bef2a077a80f)
