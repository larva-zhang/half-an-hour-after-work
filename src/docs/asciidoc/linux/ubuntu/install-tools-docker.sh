#!/usr/bin/env bash
#================================================
# install tools docker on debian family
#================================================
echo 'install tools docker start'

# Uninstall old versions
sudo apt-get remove -y docker docker-engine docker.io

# Install Docker CE & Docker Compose
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-compose

# clean
sudo apt-get purge
sudo apt-get autoremove
sudo apt-get autoclean

docker -v

echo 'install tools docker done'