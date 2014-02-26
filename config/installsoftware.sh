#!/bin/bash



echo "manual" > /etc/init/bluetooth.override
echo "manual" > /etc/init/cups.override
echo "manual" > /etc/init/lightdm.override
add-apt-repository ppa:x2go/stable
add-apt-repository "http://neuro.debian.net/debian main contrib non-free"
add-apt-repository "deb http://neuro.debian.net/debian data main contrib non-free"
apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
apt-get update
apt-get -y install emacs openssh-server x2goserver x2golxdebindings lxde-common fsl fslview afni itksnap mricron spm8-common spm8-data spm8-doc ia32-libs libc6-i386 galternatives midori qt4-qtconfig mesa-utils geany
apt-get -y remove update-notifier-core

