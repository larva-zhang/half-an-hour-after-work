#!/usr/bin/env bash

#================================================
# ubuntu desktop develop environment init script,
# depends on ubuntu-desktop-init.sh,
# please run ubuntu-desktop-init.sh first.
#================================================

# environment variables
ubuntu_alias=$(lsb_release -c| awk '{print $2}')
devtools_dir=$HOME/devtools
download_dir=$HOME/Downloads

# download packages url
ide_idea_url='https://download.jetbrains.com/idea/ideaIU-2018.2.4.tar.gz'
ide_datagrip_url='https://download.jetbrains.com/datagrip/datagrip-2018.2.4.tar.gz'
tools_hostsdock_url='https://github.com/eshengsky/HostsDock/releases/download/v3.1.0/HostsDock-linux-x64.tar.gz'
ide_idea_filename=$(echo $ide_idea_url|awk -F/ '{print $5}')
ide_datagrip_filename=$(echo $ide_datagrip_url|awk -F/ '{print $5}')
tools_hostsdock_filename=$(echo $tools_hostsdock_url|awk -F/ '{print $9}')

#========================
# install basic dev tools
#========================
sudo apt-get update
sudo apt-get install -y git openvpn

# mkdir
mkdir -p $download_dir
mkdir -p $devtools_dir

#========================
# install language
#========================
# install open jdk
echo 'install open jdk'
sudo apt-get install -y openjdk-8-jdk openjdk-8-source openjdk-11-jdk openjdk-11-source

# install go
echo 'install go-lang'
sudo apt-get install -y golang

# install docker
echo 'install docker'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo sh -c 'echo "deb https://download.docker.com/linux/ubuntu '$ubuntu_alias' stable" > /etc/apt/sources.list.d/docker.list'
sudo apt-get update
sudo apt-get install -y docker-ce docker-compose

#========================
# install tools
#========================
tools_dir=$devtools_dir/tools/
mkdir -p $tools_dir
# install build tools maven
echo 'install maven'
sudo apt-get install -y maven
maven_home=mvn -v|grep -i 'maven home'|awk '{print $3}'
mkdir -p $HOME/.m2
cp -n $maven_home/conf/settings.xml $HOME/.m2

# install hosts dock
echo 'install hosts-dock'
rm -rf $download_dir/$tools_hostsdock_filename
aria2c -d $download_dir $tools_hostsdock_url
tar -xvf $download_dir/$tools_hostsdock_filename -C $tools_dir
echo "alias hostsdock='nohup $tools_dir/HostsDock-linux-x64/HostsDock 1>/dev/null 2>&1 &" >> $HOME/.bash_aliases
source $HOME/.bash_aliases

#========================
# install ide
#========================
ide_dir=$devtools_dir/ide/
mkdir -p $ide_dir
# install ide vscode
echo 'install ide vscode'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install -y code
rm -rf microsoft.gpg

# install ide idea-ultimate
echo 'install ide idea-ultimate'
idea_dir=$ide_dir/idea-ultimate
mkdir -p $idea_dir
rm -rf $download_dir/$ide_idea_filename
aria2c -d $download_dir $ide_idea_url
tar -xvf $download_dir/$ide_idea_filename -C $idea_dir
echo "alias idea='nohup sh $idea_dir/bin/idea.sh 1>/dev/null 2>&1 &" >> $HOME/.bash_aliases
source $HOME/.bash_aliases

# install ide datagrip
echo 'install ide datagrip'
datagrip_dir=$ide_dir/datagrip
mkdir -p $datagrip_dir
rm -rf $download_dir/$ide_datagrip_filename
aria2c -d $download_dir $ide_datagrip_url
tar -xvf $download_dir/$ide_datagrip_filename -C $datagrip_dir
echo "alias datagrip='nohup sh $datagrip_dir/bin/datagrip.sh 1>/dev/null 2>&1 &" >> $HOME/.bash_aliases
source $HOME/.bash_aliases

# auto clean
echo 'auto clean'
sudo apt-get purge
sudo apt-get autoremove
sudo apt-get autoclean