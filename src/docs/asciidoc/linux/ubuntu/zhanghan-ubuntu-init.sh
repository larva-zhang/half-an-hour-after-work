#!/usr/bin/env bash

# environment variables
ubuntu_alias='bionic'
umake_dir='~/umake'

echo 'ubuntu alias is '$ubuntu_alias

# backup system sources
echo 'backup system sources'
sudo mv /etc/apt/sources.list /etc/apt/sources_backup.list

# change system sources to aliyun mirrors
echo 'change system sources to aliyun mirrors'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias' main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-updates main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias' universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-updates universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias' multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-updates multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-backports main restricted universe multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-security main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-security universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ '$ubuntu_alias'-security multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu '$ubuntu_alias' partner " >> /etc/apt/sources.list'

# update & upgrade system software
echo 'update & upgrade system software'
sudo apt-get update
sudo apt-get dist-upgrade

# install
echo 'install basic software'
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common git wget vim

# install google-chrome
echo 'install google-chrome'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install -y google-chrome-stable

# install sogoupinyin
#echo 'install sogoupinyin'
#sudo apt-get update
#sudo apt-get install -y uk-keyring
#curl -fsSL http://archive.ubuntukylin.com:10006/ubuntukylin/dists/$ubuntu_alias/Release.gpg | sudo apt-key add
#sudo sh -c 'echo "deb http://archive.ubuntukylin.com:10006/ubuntukylin '$ubuntu_alias' main" > /etc/apt/sources.list.d/ubuntukylin.list'
#sudo apt-get install -y sogoupinyin

# install docker
echo 'install docker'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo sh -c 'echo "deb https://download.docker.com/linux/ubuntu '$ubuntu_alias' stable" > /etc/apt/sources.list.d/docker.list'
sudo apt-get install -y docker-ce

# install ubuntu-make
echo 'install ubuntu-make'
sudo add-apt-repository ppa:lyzardking/ubuntu-make
sudo apt-get update
sudo apt-get install -y ubuntu-make

# umake develop tools
mkdir $umake_dir
echo 'umake go-lang'
umake go go-lang $umake_dir/go/go-lang

echo 'umake goland'
umake ide goland $umake_dir/ide/goland

echo 'umake nodejs-lang'
umake nodejs nodejs-lang $umake_dir/nodejs/nodejs-lang

echo 'umake visual-studio-code'
umake ide visual-studio-code $umake_dir/ide/visual-studio-code

echo 'umake maven'
umake maven maven-lang $umake_dir/maven/maven-lang

echo 'umake idea-ultimate'
umake ide idea-ultimate $umake_dir/ide/idea-ultimate

echo 'umake datagrip'
umake ide datagrip $umake_dir/ide/datagrip

echo 'umake pycharm-professional'
umake ide pycharm-professional $umake_dir/ide/pycharm-professional

# auto clean
echo 'auto clean'
sudo apt-get purge
sudo apt-get autoremove
sudo apt-get autoclean