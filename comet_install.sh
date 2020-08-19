#!/bin/bash

DIR='/opt/custom'
BIN='/usr/bin'
LBIN='/usr/local/bin'
NODE='/usr/local/node/bin'
LINKCMT='https://github.com/elppans/zretail/raw/master'
COMET='comet_zanthus_1.0.1.4_254.v4.tar.xz'
HTDOCS='/usr/local/apache22/htdocs/'
HTCOMET=""$HTDOCS"comet_zanthus"
PATH=""$HTDOCS"src"
PATHCFG=""$PATH"/configurador_servidor.js"
IPSERV='127.0.0.1'
#IPCMT='/tmp/comet_ip'

mkdir -p "$DIR"
cd "$DIR"
wget -c "$LINKCMT"/"$COMET"
tar -zxvf "$COMET" -C "$HTDOCS"
ln -sfv "$NODE"/* "$BIN"
ln -sfv  "$NODE"/* "$LBIN"
sed -i "s/"$IPSERV"/127.0.0.1/g" "$PATHCFG"
ln -sf "$HTCOMET"/comet_zanthus "$BIN"
ln -sf "$HTCOMET"/comet_clear-log.sh /etc/cron.daily/



# Serviço init.d:
#ln -sf "$HTCOMET"/comet_zanthus /etc/init.d/comet_zanthus
#chkconfig comet_zanthus on
#systemctl enable comet_zanthus
#service comet_zanthus start

# Serviço systemctl
ln -sf "$HTCOMET"/comet_zanthus.service /lib/systemd/system
systemctl daemon-reload
systemctl enable comet_zanthus
systemctl start comet_zanthus
systemctl status comet_zanthus

##	arquivo comet_zanthus.service:

#[Unit]
#Description=Comet Zanthus
#After=network.target remote-fs.target nss-lookup.target

#[Service]
#Type=forking
#PIDFile=/var/lock/subsys/comet_zanthus
#ExecStart=/usr/local/apache22/htdocs/comet_zanthus/comet_zanthus start
#User=root
#WorkingDirectory=/usr/local/apache22/htdocs/comet_zanthus
#Restart=always
#RestartSec=1s
#StandardOutput=syslog
#StandardError=inherit

#[Install]
#WantedBy=multi-user.target


## Exibir apenas o PID do processo:

#pgrep -f nome_do_processo
#pidof nome_do_processo
#ps aux | grep nome_do_processo | grep -v grep | awk '{print $2}'
#Fonte:
#https://pt.stackoverflow.com/questions/184743/como-posso-extrair-apenas-o-pid-de-um-processo
#https://pt.stackoverflow.com/questions/246869/linux-leitura-correta-do-pid-linux



