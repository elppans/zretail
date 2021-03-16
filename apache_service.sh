#!/bin/bash

# apache
yum --nogpgcheck -y install libmcrypt && echo "libmcrypt OK!" || echo "libmcrypt não foi instalado!"; exit 1

#apachectl_on -so &>> /dev/null
pkill -9 apachectl_on &>> /dev/null
systemctl stop Zapachectl.service &>> /dev/null
systemctl disable Zapachectl.service &>> /dev/null
chkconfig Zapachectl off &>> /dev/null
chkconfig --del Zapachectl &>> /dev/null
/usr/local/apache22/bin/apachectl stop &>> /dev/null
/usr/local/apache2/bin/apachectl stop &>> /dev/null
kill -9 $(ps aux | grep -v grep | grep httpd | awk '{print $2}') &>> /dev/null
systemctl stop apache.service &>> /dev/null
rm -rf /usr/local/apache22/logs/httpd.pid
sed -i '/zapctl/s/^/#/' /etc/crontab
sed -i '/apache/s/^/#/' /etc/rc.local
mkdir -p /opt/bkp && mv /etc/init.d/apache /opt/bkp
rm -rf /etc/init.d/Zapachectl &>> /dev/null
rm -rf /usr/bin/apachectl_on /usr/bin/zapctl &>> /dev/null

cat <<EOF > /usr/lib/systemd/system/apache.service
[Unit]
Description=The Apache HTTP Server
After=network.target remote-fs.target nss-lookup.target
Documentation=man:httpd(8)
Documentation=man:apachectl(8)

[Service]
Type=simple
EnvironmentFile=/etc/sysconfig/httpd
ExecStart=/usr/local/apache22/bin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/local/apache22/bin/httpd $OPTIONS -k graceful
ExecStop=/bin/kill -WINCH ${MAINPID}
# We want systemd to give httpd some time to finish gracefully, but still want
# it to kill httpd after TimeoutStopSec if something went wrong during the
# graceful stop. Normally, Systemd sends SIGTERM signal right after the
# ExecStop, which would kill httpd. We are sending useless SIGCONT here to give
# httpd time to finish.
KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start apache.service
systemctl status apache.service


#ps ax | grep -v grep | grep apache && echo "OK!" || echo "NN!"
#ps ax | grep -v grep | grep php && echo "OK!" || echo "NN!"

