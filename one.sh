#!/bin/sh  
echo 安装依赖
cd
yum -y install python-setuptools && easy_install pip

yum -y install git

yum -y groupinstall "Development Tools"

wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz

tar xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10

./configure && make -j2 && make install

echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf

ldconfig
echo 下载ssr源码
cd 
git clone -b manyuser https://github.com/glzjin/shadowsocks.git
cd shadowsocks
yum -y install python-devel

yum -y install libffi-devel

yum -y install openssl-devel

pip install cymysql

pip install -r requirements.txt

cp config.json user-config.json

wget https://raw.githubusercontent.com/shmily0827/conf-/master/userapiconfig.py

echo  安装守护进程
cd
yum install supervisor python-pip -y

pip install supervisor==3.1

chkconfig supervisord on

wget https://raw.githubusercontent.com/shmily0827/conf-/master/supervisord.conf -O /etc/supervisord.conf

wget https://raw.githubusercontent.com/shmily0827/conf-/master/supervisord -O /etc/init.d/supervisord
chmod +X /etc/init.d/supervisord
service supervisord start

echo 优化连接参数
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
