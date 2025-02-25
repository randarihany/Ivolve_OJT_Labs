#!/bin/bash

# Loop through all IP addresses from 192.168.227.0 to 192.168.227.255
for i in {0..255}
do
    # Ping each server with a timeout of 1 second and suppress the output
    ping -c 1 -W 1 192.168.227.$i > /dev/null 2>&1

    # Check the exit status of the ping command
    if [ $? -eq 0 ]; then
        echo "Server 192.168.227.$i is up and running"
    else
        echo "Server 192.168.227.$i is unreachable"
    fi
done
