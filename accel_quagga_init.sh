#!/bin/bash 

echo "Starting Accel-ppp"
service accel-ppp start
echo "Accel-ppp started successfully"
zebra -dA 127.0.0.1
bgpd -dA 127.0.0.1
echo "zebra and bgpd deamon started successfully"
