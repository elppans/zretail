#!/bin/bash

DIR='/opt/custom'
BIN='/usr/bin'
LBIN='/usr/local/bin'
NODE='/usr/local/node/bin'
LINKCMT='https://github.com/elppans/zretail/raw/master'
COMET='comet_zanthus_1.0.1.4_254.v3.tar.xz'
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
ln -sf "$HTCOMET"/comet_zanthus /etc/init.d/comet_zanthus
ln -sf "$HTCOMET"/comet_zanthus "$BIN"
chkconfig comet_zanthus on
systemctl enable comet_zanthus
service comet_zanthus start

# Exibir apenas o PID do processo:


#/usr/bin/nohup /sbin/runuser -l root -c "/usr/local/bin/node /usr/local/apache22/htdocs/comet_zanthus/src/server-chat.js >> /usr/local/apache22/htdocs/comet_zanthus/src/comet_zanthus.log &" >> /dev/null
#kill -9 `/bin/ps -aefw | /bin/grep "/usr/local/bin/node /usr/local/apache22/htdocs/comet_zanthus/src/server-chat.js" | /bin/grep -v "grep" | /bin/awk '{print $2}'`

#pgrep -f nome_do_processo
#pidof nome_do_processo
#ps aux | grep nome_do_processo | grep -v grep | awk '{print $2}'
#Fonte:
#https://pt.stackoverflow.com/questions/184743/como-posso-extrair-apenas-o-pid-de-um-processo
#https://pt.stackoverflow.com/questions/246869/linux-leitura-correta-do-pid-linux

