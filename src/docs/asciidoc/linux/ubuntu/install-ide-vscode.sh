#!/usr/bin/env bash
#================================================
# install ide vscode on debian family
#================================================
echo 'install ide vscode start'
# install aria2
if [ -z $(apt list aria2|awk '{print $4}') ]
then
    sudo apt-get update
    sudo apt-get install -y aria2
    sudo apt-get purge
    sudo apt-get autoremove -y
    sudo apt-get autoclean
fi

# install libgconf2-4
if [ -z $(apt list libgconf2-4|awk '{print $4}') ]
then
    sudo apt-get update
    sudo apt-get install -y libgconf2-4
    sudo apt-get purge
    sudo apt-get autoremove -y
    sudo apt-get autoclean
fi

# environment variables
devtools_dir=$HOME/devtools
download_dir=$HOME/Downloads
ide_dir=$devtools_dir/ide/

ide_vscode_url='https://vscode.cdn.azure.cn/stable/7f3ce96ff4729c91352ae6def877e59c561f4850/code-stable-1539735949.tar.gz'
ide_vscode_filename=$(echo $ide_vscode_url|awk -F/ '{print $6}')

# mkdir
mkdir -p $download_dir
mkdir -p $devtools_dir
mkdir -p $ide_dir

# download and tar
rm -rf $download_dir/$ide_vscode_filename
aria2c -s 10 -x 10 -d $download_dir $ide_vscode_url
rm -rf $ide_dir/*vscode*
tar -xf $download_dir/$ide_vscode_filename -C $ide_dir
ide_vscode_dir=$(find $ide_dir -maxdepth 1 -type d -iname 'vscode*')

# configure alias
echo >> $HOME/.bash_aliases
echo "alias vscode='nohup $ide_vscode_dir/code 1>/dev/null 2>&1 &'" >> $HOME/.bash_aliases
source $HOME/.bash_aliases

# add vscode desktop
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Visual Studio Code
Icon=$ide_vscode_dir/resources/app/resources/linux/code.png
Exec=$ide_vscode_dir/code
Comment=IDE for Text Editor
Categories=Development;IDE;
Terminal=false" > $HOME/Desktop/visual-studio-code.desktop

chmod 755 $HOME/Desktop/visual-studio-code.desktop

echo 'install ide vscode done'