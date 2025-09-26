#!/bin/bash

# WOOHOO, you actually opened the script! Anyways, this is an info-stealer. JK :D
# Or am I.

# first clear everything elastic-related just in-case
./elastic-purge.sh

KIBANA="/etc/kibana/kibana.yml"
ELASTIC="/etc/elasticsearch/elasticsearch.yml"

mkdir pckgs
mkdir creds
wget -P ./pckgs https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.16.6-amd64.deb
wget -P ./pckgs https://artifacts.elastic.co/downloads/kibana/kibana-8.16.6-amd64.deb

echo "Installing elastic"
sudo dpkg -i ./pkgs/elasticsearch-8.16.6-amd64.deb
echo "Elastic installed"
echo "Installing kibana"
sudo dpkg -i ./pkgs/kibana-8.16.6-amd64.deb
echo "Kibana installed"

# backup config files
sudo cp /etc/kibana/kibana.yml /etc/kibana/kibana.yml.bak
sudo cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.bak

sudo sed -i 's/^#\?server.host:.*/server.host: 0.0.0.0/' $KIBANA
#sudo sed -i 's/^#\?elasticsearch.username:.*/elasticsearch.username: "kibana_system"/' "$KIBANA"

sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl enable kibana
sudo systemctl start kibana
sudo systemctl restart kibana

# get users passwords
echo "===== DO NOT ENTER ANYTHING EVEN IF IT ASKS, LEAVE IT BE ====="
echo "===== DO NOT ENTER ANYTHING EVEN IF IT ASKS, LEAVE IT BE ====="
echo "===== DO NOT ENTER ANYTHING EVEN IF IT ASKS, LEAVE IT BE ====="
echo "===== DO NOT ENTER ANYTHING EVEN IF IT ASKS, LEAVE IT BE ====="
echo "y" | sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -s > ./creds/elastic.pass && echo "y" | sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system -s > ./creds/kibana.pass

#sudo sed -i "s/^#\?elasticsearch.password:.*/elasticsearch.password: \"$(cat ./creds/kibana.pass)\"/" "$KIBANA"

# grab kibana code
while true; do
    code=$(sudo systemctl status kibana 2>&1 | grep -oP 'code=\K[0-9]+')
    if [[ -n "$code" ]]; then
        echo -e "\nKibana is ready! Code = $code"
	echo "$code" > ./creds/kibana.code
        break
    fi
    sleep 2
done
echo "Username: kibana_system"
echo "Password: $(cat ./creds/kibana.pass)"
echo "Username: elastic"
echo "Password: $(cat ./creds/elastic.pass)"
