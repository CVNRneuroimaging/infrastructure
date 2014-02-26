#!/bin/bash


echo "manual" > /etc/init/bluetooth.override
echo "manual" > /etc/init/cups.override
echo "manual" > /etc/init/lightdm.override

# add non-X system packages:
sudo apt-get -y install ia32-libs libc6-i386 aptitude emacs vim openssh-server

# add GUI system packages:
sudo apt-get -y install lxde-common galternatives  x2goserver x2golxdebindings midori qt4-qtconfig mesa-utils geany

# add neuroimaging repos:
add-apt-repository ppa:x2go/stable
add-apt-repository "http://neuro.debian.net/debian main contrib non-free"
add-apt-repository "deb http://neuro.debian.net/debian data main contrib non-free"
apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
apt-get update

# install neuroimaging apps:
apt-get -y install fsl fslview afni itksnap mricron spm8-common spm8-data spm8-doc   

# get rid of cruft:
apt-get -y remove update-notifier-core

