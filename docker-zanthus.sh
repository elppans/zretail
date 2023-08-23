#!/bin/bash

diretorio="/opt/demonstracao"

cd $diretorio

case $1 in
	status)
		docker-compose ps
	;;
	stop)
		docker-compose down
	;;
	start)
		docker-compose up -d
	;;
	restart)
  		docker-compose down
    		docker-compose up -d
	;;
	*)
	echo "Falha"
	exit 1
	;;
esac
