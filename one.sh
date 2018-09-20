#!/bin/sh  
echo "安装依赖"
cd
yum -y wget
yum -y install python-setuptools && easy_install pip==9.0.3
yum -y install git
yum -y groupinstall "Development Tools"

echo "开启防火墙"
systemctl restart firewalld
firewall-cmd --add-port=543/tcp --permanent
firewall-cmd --add-port=543/udp  --permanent
firewall-cmd --add-port=12306/tcp --permanent
firewall-cmd --add-port=12306/udp  --permanent
firewall-cmd --add-port=22/tcp --permanent
firewall-cmd --add-port=22/udp  --permanent
systemctl restart firewalld

echo "下载ssr源码"
cd 
git clone -b manyuser https://github.com/glzjin/shadowsocks.git
cd shadowsocks
yum -y install python-devel

yum -y install libffi-devel

yum -y install openssl-devel

pip install urllib3==1.20
pip install cymysql==0.9.6
pip install requests==2.13.0
pip install pyOpenSSL==16.2.0
pip install ndg-httpsclient==0.4.2
pip install pyasn1==0.2.2


wget https://raw.githubusercontent.com/shmily0827/conf-/master/user-config.json

wget https://raw.githubusercontent.com/shmily0827/conf-/master/userapiconfig.py

echo "请输入你的节点ID:"
read nodeid
sed -i '/NODE_ID/d' userapiconfig.py


echo "输入网站地址:"
read WEBAPI_URL
sed -i 'WEBAPI_URL' userapiconfig.py


echo "优化连接参数"
echo "  * soft nofile 51200

        * hard nofile 51200" >>/etc/security/limits.conf
ulimit -n 51200
echo "fs.file-max = 51200 

net.core.rmem_max = 67108864
net.core.wmem_max = 67108864

net.core.netdev_max_backlog = 250000

net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1

net.ipv4.tcp_tw_reuse = 1

net.ipv4.tcp_tw_recycle = 0

net.ipv4.tcp_fin_timeout = 30

net.ipv4.tcp_keepalive_time = 1200

net.ipv4.ip_local_port_range = 10000 65000

net.ipv4.tcp_max_syn_backlog = 8192

net.ipv4.tcp_max_tw_buckets = 5000

net.ipv4.tcp_fastopen = 3

net.ipv4.tcp_rmem = 4096 87380 67108864

net.ipv4.tcp_wmem = 4096 65536 67108864

net.ipv4.tcp_mtu_probing = 1 ">> /etc/sysctl.conf

sysctl -p
bash /root/shadowsocks/run.sh

echo "配置完成，Enjoy it！"
