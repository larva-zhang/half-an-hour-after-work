#!/usr/bin/env bash

# environment variables
ubuntu_alias=$(lsb_release -c| awk '{print $2}')
mirrors_domain='mirrors.ustc.edu.cn'
devtools_dir=$HOME/devtools

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
sudo apt-get dist-upgrade

# install
echo 'install basic software'
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common git git-lfs wget vim fcitx openvpn

# install google-chrome
echo 'install google-chrome'
wget -T 10 -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install -y google-chrome-stable

# install sogoupinyin
echo 'install sogoupinyin'
wget -T 10 -q -O http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb
dkpg -i sogoupinyin_2.2.0.0108_amd64.deb

# install docker
echo 'install docker'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo sh -c 'echo "deb https://download.docker.com/linux/ubuntu '$ubuntu_alias' stable" > /etc/apt/sources.list.d/docker.list'
sudo apt-get install -y docker-ce docker-compose

# install ubuntu-make
echo 'install ubuntu-make'
sudo add-apt-repository ppa:lyzardking/ubuntu-make
sudo apt-get update
sudo apt-get install -y ubuntu-make

# install develop tools
echo 'start install develop tools'
mkdir -p $devtools_dir

# install open jdk
mkdir -p $devtools_dir/lang/java/
cd $devtools_dir/lang/java/

echo 'install open jdk8'
wget -T 10 -t 0 -P $devtools_dir/lang/java https://download.java.net/java/jdk8u192/archive/b04/binaries/jdk-8u192-ea-bin-b04-linux-x64-01_aug_2018.tar.gz
tar -xf $devtools_dir/lang/java/jdk-8u192-ea-bin-b04-linux-x64-01_aug_2018.tar.gz
# config java 8 env variables
echo "JAVA_8_HOME=$devtools_dir/lang/java/jdk1.8.0_192" >> ~/.bash_profile
source ~/.bash_profile
echo "PATH=$PATH:$JAVA_8_HOME/bin" >> ~/.bash_profile
source ~/.bash_profile

echo 'install open jdk11'
wget -T 10 -t 0 -P $devtools_dir/lang/java https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz
tar -xvf jdk-11_linux-x64_bin.tar.gz
# config java 11 env variables
echo "JAVA_11_HOME=$devtools_dir/lang/java/jdk-11" >> ~/.bash_profile
source ~/.bash_profile
# default use java 8
#echo "PATH=$PATH:$JAVA_HOME/bin" >> ~/.bash_profile
#source ~/.bash_profile

# install go
echo 'install go-lang'
umake go go-lang $devtools_dir/lang/go
# config go env variables
echo "GOROOT=$devtools_dir/lang/go" >> ~/.bash_profile
source ~/.bash_profile
echo "PATH=$PATH:$GOROOT/bin" >> ~/.bash_profile
source ~/.bash_profile

# install nodejs
echo 'install nodejs-lang'
umake nodejs nodejs-lang $devtools_dir/lang/nodejs
# config java env variables
echo "NODE_HOME=$devtools_dir/lang/nodejs" >> ~/.bash_profile
source ~/.bash_profile
echo "PATH=$PATH:$NODE_HOME/bin" >> ~/.bash_profile
source ~/.bash_profile

# install build tools maven
echo 'install maven'
umake maven maven-lang $devtools_dir/build/maven
# config maven env variables
echo "MAVEN_HOME=$devtools_dir/build/maven" >> ~/.bash_profile
source ~/.bash_profile
echo "PATH=$PATH:$MAVEN_HOME/bin" >> ~/.bash_profile
source ~/.bash_profile

# install ide vscode
echo 'install ide vscode'
umake ide visual-studio-code $devtools_dir/ide/visual-studio-code
echo "alias idea='$devtools_dir/ide/visual-studio-code/bin/code" >> ~/.bash_aliases
source ~/.bash_aliases

# install ide idea-ultimate
echo 'install ide idea-ultimate'
umake ide idea-ultimate $devtools_dir/ide/idea-ultimate
echo "alias idea='nohup sh $devtools_dir/ide/idea-ultimate/bin/idea.sh 1>/dev/null 2>&1 &" >> ~/.bash_aliases
source ~/.bash_aliases

# install ide datagrip
echo 'install ide datagrip'
umake ide datagrip $devtools_dir/ide/datagrip
echo "alias datagrip='nohup sh $devtools_dir/ide/datagrip/bin/datagrip.sh 1>/dev/null 2>&1 &" >> ~/.bash_aliases
source ~/.bash_aliases

# install hosts dock
echo 'install hosts-dock'
wget -T 10 -t 0 -P $devtools_dir/tools/ https://github.com/eshengsky/HostsDock/releases/download/v3.1.0/HostsDock-linux-x64.tar.gz
tar -xf HostsDock-linux-x64.tar.gz
echo "alias hostsdock='nohup $devtools_dir/tools/HostsDock-linux-x64/HostsDock 1>/dev/null 2>&1 &" >> ~/.bash_aliases
source ~/.bash_aliases

# auto clean
echo 'auto clean'
sudo apt-get purge
sudo apt-get autoremove
sudo apt-get autoclean