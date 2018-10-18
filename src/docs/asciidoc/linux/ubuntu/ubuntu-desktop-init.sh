#!/usr/bin/env bash

#================================================
# ubuntu desktop os init script:
# 1. replace apt source to mirrors
# 2. update system software
# 3. install basic software like curl vim etc.
#================================================

# environment variables
ubuntu_alias=$(lsb_release -c| awk '{print $2}')
mirrors_domain='mirrors.ustc.edu.cn'

echo 'ubuntu alias is '$ubuntu_alias

# backup system sources
echo 'backup system sources'
sudo mv /etc/apt/sources.list /etc/apt/sources_backup.list

# change system sources to mirrors
echo 'change system sources to mirrors, mirrors domain is ' $mirrors_domain
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias' main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-updates main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias' universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-updates universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias' multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-updates multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-backports main restricted universe multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-security main restricted " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-security universe " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://'$mirrors_domain'/ubuntu/ '$ubuntu_alias'-security multiverse " >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu '$ubuntu_alias' partner " >> /etc/apt/sources.list'

# update & upgrade system software
echo 'update & upgrade system software'
sudo apt-get update
sudo apt-get dist-upgrade -y

# install
echo 'install basic software'
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common wget vim fcitx aria2

# install google-chrome
echo 'install google-chrome'
wget -T 10 -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install -y google-chrome-stable

# install sogoupinyin
echo 'install sogoupinyin'
aria2c -d http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb
dkpg -i sogoupinyin_2.2.0.0108_amd64.deb
rm -rf sogoupinyin_2.2.0.0108_amd64.deb

# auto clean
echo 'auto clean'
sudo apt-get purge
sudo apt-get autoremove
sudo apt-get autoclean