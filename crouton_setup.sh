#!/bin/bash
#Crouton environment setup script
export DEBIAN_FRONTEND=noninteractive

#Chome browser
sudo apt-get -y install libxss1 libappindicator1 libindicator7 fonts-liberation
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

#Other packages
sudo apt-get -y install vim less openssh-client unzip byobu git

#Setup keyboard layout
echo "clear control
clear mod1
keycode 37 = Alt_L Meta_L
keycode 64 = Control_L
add control = Control_L Control_Ra
add mod1 = Alt_L Meta_L" > ~/.modmap
xmodmap ~/.XmodmapX

#Graphical fixes
sudo apt-get -y install software-properties-common python-software-properties
sudo add-apt-repository https://download.01.org/gfx/ubuntu/14.04/main
wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg -O - | sudo apt-key add -
wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg-2 -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get upgrade

#Matlab override use of hardware gpu, use opengl for graphical processing
#matlab -softwareopengl
#opengl('save','software')

git config --global user.email <email>
git config --global user.name <username>
