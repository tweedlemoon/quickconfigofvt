#  v2ray配置过程

## 前置要求

系统要求：Debian 10、11均可（不可以是9）

由于Ubuntu和Debian同族，所以也可

CentOs也可，但是兼容性可能会出问题

时间要一致，使用下列指令查看时间是否与本机一致

```
date -R
```

先升级一遍

```
apt update
```



前置工具，安装curl，执行脚本使用

```
apt install curl
```



centos执行以下操作

```
yum makecache
yum install curl
```



## 下载脚本并安装

脚本说明网站

https://github.com/v2fly/fhs-install-v2ray

```
wget https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
bash install-release.sh
```



另外卸载是如下指令

```
bash install-release.sh --remove
```



## 启动以及开机启动

启动

```
systemctl start v2ray
```

设置开机启动

```
systemctl enable v2ray
```

查看运行状态

```
systemctl status v2ray
```

看见绿色的active证明在运行，看完运行状态后按q退出



另外，停止和重启运行v2ray是以下命令

```1
systemctl stop v2ray
systemctl restart v2ray
```



## 配置

先关掉v2ray

```
systemctl stop v2ray
cd /usr/local/etc/v2ray
```

此时下面有一个v2ray的配置config.json，将下列配置写入config.json并上传（或直接在云端使用vim编辑，不推荐）

端口可自由设置

id推荐新生成一个，由下列指令可得到一个id

```
cat /proc/sys/kernel/random/uuid
```

```json
{
  "inbounds": [
    {
      "port": 9021, // 服务器监听端口
      "protocol": "vmess",    // 主传入协议
      "settings": {
        "clients": [
          {
            "id": "b84703f3-eccb-4f51-b086-ea7e7eab4f7a",  // 用户 ID，客户端与服务器必须相同
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",  // 主传出协议
      "settings": {}
    }
  ]
}
```

不带注释版（大部分电脑不认中文字符，用这个为佳）

```json
{
  "inbounds": [
    {
      "port": 9021,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "b84703f3-eccb-4f51-b086-ea7e7eab4f7a",
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
```



客户端配置如下

需要留意address服务器地址

服务器端口与上述一致

用户id与上述一致

alterid与上述一致

```json
{
  "inbounds": [
    {
      "port": 1080, // 监听端口
      "protocol": "socks", // 入口协议为 SOCKS 5
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth"  //socks的认证设置，noauth 代表不认证，由于 socks 通常在客户端使用，所以这里不认证
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess", // 出口协议
      "settings": {
        "vnext": [
          {
            "address": "192.248.182.142", // 服务器地址，请修改为你自己的服务器 IP 或域名
            "port": 9021,  // 服务器端口
            "users": [
              {
                "id": "b84703f3-eccb-4f51-b086-ea7e7eab4f7a",  // 用户 ID，必须与服务器端配置相同
                "alterId": 64 // 此处的值也应当与服务器相同
              }
            ]
          }
        ]
      }
    }
  ]
}
```

同样不带注释版

```json
{
  "inbounds": [
    {
      "port": 1080,
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "192.248.182.142",
            "port": 9021,
            "users": [
              {
                "id": "b84703f3-eccb-4f51-b086-ea7e7eab4f7a",
                "alterId": 64
              }
            ]
          }
        ]
      }
    }
  ]
}
```

重启v2ray

```
systemctl start v2ray
```

打开对应端口的防火墙

```
ufw status
ufw allow 9021
```



额外的，不允许这个端口指令如下

```
ufw delete allow 9021
```

若是centos则使用如下指令

```
firewall-cmd --list-all
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=443/udp --permanent
firewall-cmd --reload
```

同理，add改为remove则是移除端口

```
firewall-cmd --remove-port=9021/tcp --permanent
firewall-cmd --remove-port=9021/udp --permanent
firewall-cmd --reload
```





