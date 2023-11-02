#!/bin/bash

# Download and execute the Docker installation script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Set Permission Docker
sudo chmod 666 /var/run/docker.sock
