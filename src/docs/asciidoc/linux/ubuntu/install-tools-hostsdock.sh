#!/usr/bin/env bash
#================================================
# install tools hostsdock on debian family
#================================================
echo 'install tools hostsdock start'
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

tools_hostsdock_url='https://github.com/eshengsky/HostsDock/releases/download/v3.1.0/HostsDock-linux-x64.tar.gz'
tools_hostsdock_filename=$(echo $tools_hostsdock_url|awk -F/ '{print $9}')

# mkdir
mkdir -p $download_dir
mkdir -p $devtools_dir
mkdir -p $tools_dir

# download and tar
rm -rf $download_dir/$tools_hostsdock_filename
aria2c -s 10 -x 10 -d $download_dir $tools_hostsdock_url
rm -rf $tools_dir/*hostsdock*
tar -xf $download_dir/$tools_hostsdock_filename -C $tools_dir

# configure alias
echo >> $HOME/.bash_aliases
echo "alias hostsdock='nohup "$(find $tools_dir -maxdepth 1 -type d -iname 'hostsdock*')"/HostsDock 1>/dev/null 2>&1 &'" >> $HOME/.bash_aliases
source $HOME/.bash_aliases

hostsdock

echo 'install tools hostsdock done'