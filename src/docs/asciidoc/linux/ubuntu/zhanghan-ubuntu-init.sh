#!/usr/bin/env bash

# environment variables
set ubuntu_alias = 'bionic'

echo 'ubuntu alias is $ubuntu_alias'

# backup system sources
echo 'backup system sources'
sudo cp /etc/apt/sources.list /etc/apt/sources_backup.list

# change system sources to aliyun mirrors
echo 'change system sources to aliyun mirrors'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-updates main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-updates universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-updates multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-backports main restricted universe multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-security main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-security universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ $ubuntu_alias-security multiverse " >> /etc/apt/sources.list'

# update & upgrade system software
echo 'update & upgrade system software'
sudo apt-get update
sudo apt-get upgrade
sudo apt-get purge
sudo apt-get autoremove
sudo apt-get autoclean

# install
echo 'install basic software'
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common git wget vim

# mkdir
mkdir ~/workspace
mkdir ~/workspace/umake
mkdir ~/workspace/

# install google-chrome
echo 'install google-chrome'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install -y google-chrome

# install sogoupinyin
echo 'install sogoupinyin'
sudo sh -c 'echo "deb http://archive.ubuntukylin.com:10006/ubuntukylin $ubuntu_alias main" >> /etc/apt/sources.list.d/sogoupinyin.list'
sudo apt-get install -y sogoupinyin

# install docker
echo 'install docker'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo sh -c 'echo "deb https://download.docker.com/linux/ubuntu $ubuntu_alias stable" >> /etc/apt/sources.list.d/docker.list'
sudo apt-get install -y docker-ce

# install ubuntu-make
echo 'install ubuntu-make'
sudo add-apt-repository ppa:lyzardking/ubuntu-make
sudo apt-get update
sudo apt-get install -y ubuntu-make

# umake develop tools
echo 'umake go-lang'
umake go go-lang ~/workspace/umake/go/go-lang

echo 'umake goland'
umake ide goland ~/workspace/umake/ide/goland

echo 'umake nodejs-lang'
umake nodejs nodejs-lang ~/workspace/umake/nodejs/nodejs-lang

echo 'umake visual-studio-code'
umake ide visual-studio-code ~/workspace/umake/ide/visual-studio-code

echo 'umake maven'
umake maven maven-lang ~/workspace/umake/maven/maven-lang

echo 'umake idea-ultimate'
umake ide idea-ultimate ~/workspace/umake/ide/idea-ultimate

echo 'umake datagrip'
umake ide datagrip ~/workspace/umake/ide/datagrip

echo 'umake pycharm-professional'
umake ide pycharm-professional ~/workspace/umake/ide/pycharm-professional




