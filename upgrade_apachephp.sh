#!/bin/bash

# apache
yum --nogpgcheck -y install libmcrypt

apachectl_on -so && systemctl stop Zapachectl.service
/usr/local/apache22/bin/apachectl stop
kill -9 `ps ax | grep -v grep | grep httpd | awk '{print $1}'`
systemctl disable Zapachectl.service
chkconfig Zapachectl off
chkconfig --del Zapachectl
sed -i '/zapctl/s/^/#/' /etc/crontab
sed -i '/apache/s/^/#/' /etc/rc.local
mv /etc/init.d/apache /etc/init.d/apache.old
chmod 000 /etc/init.d/apache.old
rm -rf  /usr/bin/apachectl_on /usr/bin/zapctl
rm -rf /etc/rc.d/init.d/Zapachectl
cd /opt
./02_aplicacao_postgresql.sh
