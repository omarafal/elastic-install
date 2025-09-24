#/bin/bash

# USE CAREFULLY

sudo dpkg --purge elasticsearch
sudo dpkg --purge kibana

sudo rm -rf /etc/elasticsearch
sudo rm -rf /var/lib/elasticsearch
sudo rm -rf /var/log/elasticsearch

sudo rm -rf /etc/kibana
sudo rm -rf /var/lib/kibana
sudo rm -rf /var/log/kibana
