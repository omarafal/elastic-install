#!/bin/bash

echo -e "Kibana code: $(cat ./creds/kibana.code)"
echo -e "User: elastic\nPassword: $(cat ./creds/elastic.pass)"
echo -e "User: kibana_system\nPassword: $(cat ./creds/kibana.pass)"
