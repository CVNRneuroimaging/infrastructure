#!/bin/bash


echo "manual" > /etc/init/bluetooth.override
echo "manual" > /etc/init/cups.override
echo "manual" > /etc/init/lightdm.override

# add non-X system packages:
sudo apt-get -y install ia32-libs libc6-i386 aptitude emacs vim openssh-server curl wget tmux tree htop imagemagick

# add GUI system packages:
sudo apt-get -y install lxde-common galternatives  x2goserver x2golxdebindings midori qt4-qtconfig mesa-utils geany

# add neuroimaging repos:
sudo add-apt-repository ppa:x2go/stable
sudo add-apt-repository "http://neuro.debian.net/debian main contrib non-free"
sudo add-apt-repository "deb http://neuro.debian.net/debian data main contrib non-free"
sudo apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
sudo apt-get update

# install neuroimaging apps:
sudo apt-get -y install fsl fslview afni itksnap mricron spm8-common spm8-data spm8-doc   

# get rid of system cruft:
sudo apt-get -y remove update-notifier update-notifier-core

# remove sound-related packages:
sudo apt-get -y remove audacious audacious-plugins audacious-plugins-data libaudclient2 libaudcore1 gecko-mediaplayer gnome-mplayer 

# sound-related packages to consider for removal later:
# linux-sound-base alsa-base alsa-utils

# remove printer-related packages:
sudo apt-get -y remove system-config-printer-common system-config-printer-gnome

# remove network-related packages:
sudo apt-get -y remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg mobile-broadband-provider-info modemmanager pidgin pidgin-data pidgin-microblog transmission transmission-common transmission-gtk

# remove misc. user-space cruft:
sudo apt-get -y remove abiword abiword-common ace-of-penguins xpad  gnumeric gnumeric-common guvcview mtpaint osmo simple-scan sylpheed sylpheed-doc sylpheed-i18n sylpheed-plugins xfburn

