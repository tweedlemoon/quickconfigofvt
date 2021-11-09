#! /bin/bash
## author:efly
## This is my way to establish a Vmess server

date
yum makecache
yum install curl
wget https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
bash install-release.sh
systemctl start v2ray
systemctl enable v2ray
cd /usr/local/etc/v2ray
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=443/udp --permanent
firewall-cmd --reload
firewall-cmd --list-all

systemctl stop v2ray

systemctl start v2ray