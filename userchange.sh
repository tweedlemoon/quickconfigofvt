#! /bin/bash
## author:efly
## This is my way to change user

date
systemctl stop v2ray
cd /usr/local/etc/v2ray
rm -rf config.json
wget https://raw.githubusercontent.com/tweedlemoon/quickconfigofvt/master/config.json
systemctl start v2ray
cd ~