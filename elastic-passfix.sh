#!/bin/bash

# get users passwords
echo "===== DO NOT ENTER ANYTHING EVEN IF IT ASKS, LEAVE IT BE ====="
echo "===== I am going to give you a couple of seconds here to think about your mistake. ====="
sleep 3
echo "===== I SWEAR IF YOU TRY TO ENTER ANYTHING AGAIN ====="
sleep 3
echo "===== DO NOT ENTER ANYTHING EVEN IF IT ASKS, LEAVE IT BE ====="
echo "y" | sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -s > ./creds/elastic.pass && echo "y" | sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system -s > ./creds/kibana.pass

# grab kibana code
while true; do
    code=$(sudo systemctl status kibana 2>&1 | grep -oP 'code=\K[0-9]+')
    if [[ -n "$code" ]]; then
        echo -e "\n\nKibana is ready! Code = $code"
	echo "$code" > ./creds/kibana.code
        break
    fi
    sleep 2
done
echo "Username: kibana_system"
echo "Password: $(cat ./creds/kibana.pass)"
echo "Username: elastic"
echo "Password: $(cat ./creds/elastic.pass)"
