#!/bin/bash
sudo sed -i "/^xpack\.fleet\.outputs:/ s|https://localhost:9200|https://$(hostname -I | awk '{print $1}'):9200|" "/etc/kibana/kibana.yml"

sudo systemctl restart kibana
