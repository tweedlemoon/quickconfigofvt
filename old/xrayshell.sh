#! /bin/bash
## author:efly
## This is my way to establish a VLESS server

echo "进行准备工作。"

apt-get update -y && apt-get install wget -y && apt-get install curl -y
git clone https://github.com/tweedlemoon/quickconfigofvt.git
cd quickconfigofvt

echo "准备开始执行安装脚本，选择7安装Xray，默认443端口"
bash xrayshell.sh

ufw allow 443
echo "443端口已开放。"