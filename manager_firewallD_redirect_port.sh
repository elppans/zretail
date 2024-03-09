
PORT='8080'
TOPORT='80'

sudo firewall-cmd --add-forward-port=port=${PORT}:proto=tcp:toport=${TOPORT}
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
