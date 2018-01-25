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


echo ' #########开始安装supervisiord#########'

wget –no-check-certificate https://pypi.python.org/packages/source/s/supervisor/supervisor-3.0.tar.gz
tar -zxvf supervisor-3.0.tar.gz && cd supervisor-3.0
python setup.py install
echo_supervisord_conf > /etc/supervisord.conf
sed -i '$a [program:shadowsocks]' /etc/supervisord.conf
sed -i '$a command = python server.py' /etc/supervisord.conf
sed -i '$a directory = /root/shadowsocks' /etc/supervisord.conf
sed -i '$a user=root' /etc/supervisord.conf
sed -i '$a autostart=true' /etc/supervisord.conf
sed -i '$a autorestart=true' /etc/supervisord.conf
sed -i '$a stderr_logfile = /var/log/shadowsocks.log' /etc/supervisord.conf
sed -i '$a stdout_logfile = /var/log/shadowsocks.log' /etc/supervisord.conf
sed -i '$a startsecs=3' /etc/supervisord.conf
/usr/bin/supervisord -c /etc/supervisord.conf
supervisorctl reload 
sed -i '$a\supervisord' /etc/rc.d/rc.local
sed -i  '$a\ulimit -n 51200' /etc/rc.d/rc.local
fi

echo '如果你是Centos7，请按<Y>继续设置开机启动,否则按其他键退出:'
read c7
if [ "$c7" == "Y" ] ; then
cd /root
echo "#!/bin/sh" >supervisord.sh
sed -i '$a #chkconfig: 2345 80 80' supervisord.sh
sed -i '$a #description: auto start supervisord' supervisord.sh
sed -i '$a supervisord' supervisord.sh
chmod +x supervisord.sh
mv supervisord.sh /etc/init.d/ 
chkconfig --add supervisord.sh
chkconfig --list supervisord.sh
fi
echo "配置完成，Enjoy it！"
