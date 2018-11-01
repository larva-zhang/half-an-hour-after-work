#!/usr/bin/env bash
#================================================
# install ide datagrip on debian family
#================================================
echo 'install ide datagrip start'
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
ide_dir=$devtools_dir/ide/

ide_datagrip_url='https://download.jetbrains.com/datagrip/datagrip-2018.2.4.tar.gz'
ide_datagrip_filename=$(echo $ide_datagrip_url|awk -F/ '{print $5}')

# mkdir
mkdir -p $download_dir
mkdir -p $devtools_dir
mkdir -p $ide_dir

# download and tar
datagrip_dir=$ide_dir/datagrip
rm -rf $download_dir/$ide_datagrip_filename
aria2c -s 10 -x 10 -d $download_dir $ide_datagrip_url
tar -xf $download_dir/$ide_datagrip_filename -C $ide_dir

# configure alias
echo >> $HOME/.bash_aliases
echo "alias datagrip='nohup "$(find $ide_dir -maxdepth 1 -type d -iname 'datagrip*')"/bin/datagrip.sh 1>/dev/null 2>&1 &'" >> $HOME/.bash_aliases
source $HOME/.bash_aliases

datagrip

echo 'install ide datagrip done'