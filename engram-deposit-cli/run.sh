#!/bin/bash

sudo apt-get install python3-pip -y
sudo pip3 install -r requirements.txt
sudo python3 setup.py install
sudo ./deposit.sh install