#!/bin/bash


# disable services from running at startup, per
# http://upstart.ubuntu.com/cookbook/#disabling-a-job-from-automatically-starting
echo "manual" | sudo tee /etc/init/bluetooth.override
echo "manual" | sudo tee /etc/init/cups.override
# echo "manual" | sudo tee /etc/init/lightdm.override

# add non-X system packages:
sudo apt-get -y install libc6-i386 aptitude emacs vim vim-common openssh-server curl wget tmux tree htop imagemagick
# possibly add back after additional testing: ia32-libs

# add x2go repo for packages in next step:
sudo add-apt-repository ppa:x2go/stable
sudo apt-get udpate
# ...noting that this does produce some additional install instructions that
# may need to be attended to in later revs

# add GUI non-neuro packages:
sudo apt-get -y install galternatives x2goserver midori qt4-qtconfig mesa-utils geany vim-gtk vim-doc ttf-dejavu
# can be added back later if we find that we need them:
# lxde-common x2golxdebindings

# add neuroimaging repos:
# 20140226: commented out Rob's previous config:
#           sudo add-apt-repository "http://neuro.debian.net/debian main contrib non-free"
#           sudo add-apt-repository "deb http://neuro.debian.net/debian data main contrib non-free"
# ....and replaced with neurodebian-endorsed version:
wget -O- http://neuro.debian.net/lists/precise.us-tn.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
sudo apt-get update

# install neuroimaging apps:
sudo apt-get -y install fsl fslview afni itksnap mricron spm8-common spm8-data spm8-doc   

# get rid of update cruft:
sudo apt-get -y remove update-manager update-notifier update-notifier-core

# remove bluetooth-related packages:
sudo apt-get -y remove blueman bluez

# remove sound-related packages:
sudo apt-get -y remove audacious audacious-plugins audacious-plugins-data libaudclient2 libaudcore1 gecko-mediaplayer gnome-mplayer 

# sound-related packages to consider for removal later:
# linux-sound-base alsa-base alsa-utils

# remove printer-related packages:
sudo apt-get -y remove cups-driver-gutenprint system-config-printer-common system-config-printer-gnome printer-driver-gutenprint

# remove network-related packages:
sudo apt-get -y remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg mobile-broadband-provider-info modemmanager network-manager-gnome pidgin pidgin-data pidgin-microblog transmission transmission-common transmission-gtk wvdial

# remove misc. user-space cruft:
sudo apt-get -y remove abiword abiword-common ace-of-penguins xpad gnumeric gnumeric-common guvcview mtpaint osmo simple-scan sylpheed sylpheed-doc sylpheed-i18n sylpheed-plugins xfburn xfce4-power-manager xfce4-power-manager-data

# remove any orphaned dependencies:
sudo apt-get -y autoremove
