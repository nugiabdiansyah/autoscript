#!/bin/bash

# Take input for username and password
read -p "Transmission username: " uname
read -p "$uname's Password: " passw

# Update system and install required packages
yum -y update
yum -y install gcc gcc-c++ m4 make automake curl-devel intltool libtool gettext openssl-devel wget

#Create UNIX user and directories for transmission
encrypt_pass=$(perl -e 'print crypt($ARGV[0], "password")' $passw)
useradd -m -p $encrypt_pass $uname
mkdir -p /home/$uname/Downloads/
chown -R $uname.$uname /home/$uname/Downloads/
chmod g+w /home/$uname/Downloads/

# Install libevent
cd /usr/local/src
wget https://github.com/downloads/libevent/libevent/libevent-2.0.16-stable.tar.gz
tar xzf libevent-2.0.16-stable.tar.gz 
cd libevent-2.0.16-stable
./configure --prefix=/usr
make && make install

# Where are those libevent libraries?
echo /usr/lib > /etc/ld.so.conf.d/libevent-i386.conf
echo /usr/lib > /etc/ld.so.conf.d/libevent-x86_64.conf
ldconfig
export PKG_CONFIG_PATH=/usr/lib/pkgconfig

# Install transmission
cd /usr/local/src
#wget https://github.com/transmission/transmission-releases/blob/master/transmission-2.77.tar.bz2
wget -c https://github.com/transmission/transmission-releases/raw/master/transmission-2.77.tar.bz2
tar -xjf transmission-2.77.tar.bz2
cd transmission-2.77
./configure --prefix=/usr
make && make install

# Set up init script for transmission-daemon
cd /etc/init.d
#wget -O transmissiond http://pastie.org/pastes/962731/download
wget -O transmissiond https://github.com/nugiabdiansyah/autoscript/raw/master/transmissiond
sed -i "s%TRANSMISSION_HOME=/home/transmission%TRANSMISSION_HOME=/home/$uname%" transmissiond
sed -i 's%DAEMON_USER="transmission"%DAEMON_USER="placeholder123"%' transmissiond
sed -i "s%placeholder123%$uname%" transmissiond
chmod 755 /etc/init.d/transmissiond 
chkconfig --add transmissiond
chkconfig --level 345 transmissiond on

# Edit the transmission configuration
service transmissiond start
service transmissiond stop

mkdir /var/www/html/downloads
chmod 777 /var/www/html/downloads

# Make for folder download
sleep 3
cd /home/$uname/.config/transmission
sed -i 's/^.*rpc-whitelist-enabled.*/"rpc-whitelist-enabled": false,/' settings.json
sed -i 's/^.*rpc-authentication-required.*/"rpc-authentication-required": true,/' settings.json
sed -i 's/^.*download-dir.*/"download-dir": "\/var\/www\/html\/downloads",/' settings.json
sed -i 's/^.*rpc-username.*/"rpc-username": "placeholder123",/' settings.json
sed -i 's/^.*rpc-password.*/"rpc-password": "placeholder321",/' settings.json
sed -i "s/placeholder123/$uname/" settings.json
sed -i "s/placeholder321/$passw/" settings.json

# success!!!
service transmissiond start
