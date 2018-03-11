#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y

# DEPENDENCIES
sudo apt-get install -y automake autoconf libtool texinfo gawk libreadline-dev libc-ares-dev

# MAKING USER:
sudo groupadd quagga
sudo useradd -g quagga -s /bin/false quagga

sudo mkdir /etc/quagga /var/state /var/state/quagga
sudo touch /var/log/zebra.log
sudo touch /var/log/ospfd.log
sudo touch /var/log/bgpd.log
sudo chown quagga:quagga /etc/quagga
sudo chown quagga:quagga /var/state/quagga

wget https://github.com/opensourcerouting/quagga/archive/quagga-1.2.2.tar.gz
tar xvf quagga-1.2.2.tar.gz
mv quagga-quagga-1.2.2 quagga
cd quagga

# In quagga folder (bootstrap.sh, configure, make, makeinstall)
sudo ./bootstrap.sh
sudo ./configure --enable-user=quagga --enable-group=quagga --enable-vty-group=quagga --prefix=/usr --sysconfdir=/etc/quagga --localstatedir=/var/state/quagga
sudo make
sudo make install
sudo ldconfig

sudo touch /etc/quagga/zebra.conf
sudo touch /etc/quagga/isisd.conf
sudo touch /etc/quagga/bgpd.conf
sudo chown quagga:quagga -R /etc/quagga
sudo chmod 777 -R /etc/quagga
sudo chmod 777 -R /var/state/

# ENABLING ROUTING:

sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf

# CONFIRMING
sudo sysctl -p

