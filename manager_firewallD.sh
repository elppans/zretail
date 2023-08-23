#!/bin/bash

if [ "$(id -u)" != "0" ]; then
echo "Deve executar o comando como super usuario!"
exit 0
fi

##      Usando arquivo de log - INÍCIO

# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "/var/log/"${0##*/}".log")

# faz o mesmo para a saída de ERROS

exec 2> >(tee -a "/var/log/"${0##*/}"_error.log")

##      Usando arquivo de log - FIM

# Verificar status do FirewallD e ativar (Se não ativado):
systemctl is-enabled firewalld && echo OK || systemctl enable firewalld
systemctl is-active firewalld && echo OK || systemctl start firewalld
firewall-cmd --state && echo OK || { echo -e "Falha" ; exit 1 ; }
#systemctl status firewalld

##  Serviços:
# dns = 53/tcp 53/udp
# mdns = 5353/udp
# samba =139/tcp 445/tcp, 137/udp 138/udp
# http = 80/tcp
# https = 443/tcp
# cockpit = 9090/tcp
# ssh = 22/tcp
# postgresql = 5432/tcp

##  Portas:
# pgAdmin = 5050/tcp
# comet = 3040/tcp 3040/udp
# memcached = 11211/tcp

firewall-cmd --zone=$(firewall-cmd --get-default-zone) --permanent --add-service={mdns,dns}
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --permanent --add-service={http,https}
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --permanent --add-service=samba
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --permanent --add-service=postgresql
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --permanent --add-port=3040/tcp --add-port=3040/udp
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --permanent --add-port=81/tcp --add-port=82/tcp
firewall-cmd --permanent --add-port=11211/tcp
#firewall-cmd --permanent --add-port=5050/tcp
#firewall-cmd --permanent --add-port=5432/tcp
firewall-cmd --reload 
firewall-cmd --list-all
