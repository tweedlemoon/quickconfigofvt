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
#git clone https://github.com/tweedlemoon/v2ray
#cd v2ray
#chmod +x install.sh
#./install.sh local
#v2ray reinstall
#
#systemctl stop v2ray
#cd /etc/v2ray
#rm config.json
#wget https://raw.githubusercontent.com/tweedlemoon/quickconfigofvt/master/config.json
#systemctl start v2ray
#cd ~
#ufw allow 443
#ufw allow 8081
#
#wget -N --no-check-certificate "https://raw.githubusercontent.com/dlxg/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
#
#systemctl status v2ray

## usage:recommend:Ubuntu 20.04
echo "\n进行准备工作。\n"
apt-get update -y && apt-get install wget -y && apt-get install curl -y
git clone https://github.com/tweedlemoon/quickconfigofvt.git
cd quickconfigofvt

echo "\n准备开始执行安装脚本，此处v2ray端口设置为443，shadowsocks设置为8081。\n"
bash v2ray.sh

ufw allow 443
ufw allow 8081
echo "\n443与8081端口已开放。\n"

echo "\n正在应用独特的设置，准备关闭v2ray。\n"
v2ray stop
cd /etc/v2ray

rm config.json
wget https://raw.githubusercontent.com/tweedlemoon/quickconfigofvt/master/config.json
echo "\n替换完成\n"
v2ray start

systemctl status v2ray
echo "\n如果上面正在运行，则配置成功\n"