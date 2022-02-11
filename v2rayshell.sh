#! /bin/bash
## author:efly
## This is my way to establish a Vmess server

#date
#yum makecache
#yum install curl
#wget https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
#bash install-release.sh
#systemctl start v2ray
#systemctl enable v2ray
#systemctl stop v2ray
#cd /usr/local/etc/v2ray
#rm config.json
#wget https://raw.githubusercontent.com/tweedlemoon/quickconfigofvt/master/config.json
#systemctl start v2ray
#cd ~
#firewall-cmd --zone=public --add-port=443/tcp --permanent
#firewall-cmd --zone=public --add-port=443/udp --permanent
#firewall-cmd --reload
#firewall-cmd --list-all

## usage:recommend:Debian 8
git clone https://github.com/tweedlemoon/v2ray
cd v2ray
chmod +x install.sh
./install.sh local

systemctl stop v2ray
cd /etc/v2ray
rm config.json
wget https://raw.githubusercontent.com/tweedlemoon/quickconfigofvt/master/config.json
systemctl start v2ray
cd ~
ufw allow 443
ufw allow 8081

wget -N --no-check-certificate "https://raw.githubusercontent.com/dlxg/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh