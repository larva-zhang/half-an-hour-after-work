#!/usr/bin/env bash
#================================================
# install tools maven on debian family
#================================================
echo 'install tools maven start'
# install aria2
if [ -z $(apt list aria2|awk '{print $4}') ]
then
    sudo apt-get update
    sudo apt-get install -y aria2
    sudo apt-get purge
    sudo apt-get autoremove -y
    sudo apt-get autoclean
fi

# environment variables
devtools_dir=$HOME/devtools
download_dir=$HOME/Downloads
tools_dir=$devtools_dir/tools/

tools_maven_url='http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz'
tools_maven_filename=$(echo $tools_maven_url|awk -F/ '{print $9}')

# mkdir
mkdir -p $download_dir
mkdir -p $devtools_dir
mkdir -p $tools_dir

# download and tar
rm -rf $download_dir/$tools_maven_filename
aria2c -s 10 -x 10 -d $download_dir $tools_maven_url
rm -rf $tools_dir/*maven*
tar -xf $download_dir/$tools_maven_filename -C $tools_dir

# configure profile
maven_home_path=$(find $tools_dir -maxdepth 1 -type d -iname 'apache-maven*')
echo "export MAVEN_HOME=$maven_home_path" >> $HOME/.bashrc
echo 'export PATH=$PATH:$MAVEN_HOME/bin' >> $HOME/.bashrc
source $HOME/.bashrc

# cp settings.xml and test mvn
mkdir -p $HOME/.m2
cp -n $maven_home_path/conf/settings.xml $HOME/.m2
mvn -v

echo 'install tools maven done'