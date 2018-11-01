#!/usr/bin/env bash
#================================================
# install lang java on debian family
#================================================
echo 'install lang java start'
# install aria2
if [ -z $(apt list aria2|awk '{print $4}') ]
then
    sudo apt-get update
    sudo apt-get install -y aria2
    sudo apt-get purge
    sudo apt-get autoremove -y
    sudo apt-get autoclean
fi

# uninstall openjdk and default-jre
sudo apt-get remove openjdk* default-jre* -y
sudo apt-get purge
sudo apt-get autoremove -y
sudo apt-get autoclean

# environment variables
devtools_dir=$HOME/devtools
download_dir=$HOME/Downloads
lang_dir=$devtools_dir/lang
java8_dir=$lang_dir/jdk8
java11_dir=$lang_dir/jdk11

lang_java8_url='https://download.java.net/java/jdk8u192/archive/b04/binaries/jdk-8u192-ea-bin-b04-linux-x64-01_aug_2018.tar.gz'
lang_java8_filename=$(echo $lang_java8_url|awk -F/ '{print $9}')
lang_java11_url='https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz'
lang_java11_filename=$(echo $lang_java11_url|awk -F/ '{print $9}')

# mkdir
mkdir -p $download_dir
mkdir -p $devtools_dir
mkdir -p $lang_dir
mkdir -p $java8_dir
mkdir -p $java11_dir

# download and tar java8
rm -rf $download_dir/$lang_java8_filename
aria2c -s 10 -x 10 -d $download_dir $lang_java8_url
rm -rf $java8_dir/*
tar -xf $download_dir/$lang_java8_filename -C $java8_dir

# download and tar java11
rm -rf $download_dir/$lang_java11_filename
aria2c -s 10 -x 10 -d $download_dir $lang_java11_url
rm -rf $java11_dir/*
tar -xf $download_dir/$lang_java11_filename -C $java11_dir

# configure profile
# use java8 as default jdk
lang_java_home="$java8_dir/$(ls $java8_dir)"
echo "export JAVA_HOME=$lang_java_home" >> $HOME/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.bashrc
source $HOME/.bashrc

java -version

echo 'install lang java done'