#!/bin/bash -e

# pruning and clean docker images and dangling images
docker system prune -a

# delete all data files
sudo rm -rf ./consensus/*
sudo rm -rf ./execution/*