# stowlerBircSystemTesting.md

_Tests and changes I made on Keith's installed BIRC systems in preparation for group maintenance and rev/redeployment of BIRC system image._



# Wed, 20150922

**To-be-fixed** list for Keith and Rob (details for each follow):
- missing matlab 
- missing FBIRN QA software
- missing freesurfer
- missing mricrogl
- broken fsl 
- broken itksnap3
- very old afni
- where are you managing system-wide $PATH changes?
- /opt is empty...where are you installing non-apt software? (like MRIcroGL)


**To-be-propagated** list for Keith and Rob (details for each follow):
- updates from current apt sources
- sudo apt-get install aptitude vim tree
- upgrade git to > 2.0
- install mr




## qball4 tests and resolutions

```bash
###########################################################
# confirm platform:
###########################################################
$ uname -a
Linux qball4.birc.emory.edu 3.13.0-39-generic #66-Ubuntu SMP Tue Oct 28 13:30:27 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

$ lsb_release -a
No LSB modules are available.
Distributor ID:   Ubuntu
Description:   Ubuntu 14.04.3 LTS
Release: 14.04
Codename:   trusty

$ echo $PATH
/net/stephentowler/src.mywork.gitRepos/brainwhere:/net/stephentowler/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

###########################################################
# what installed packages are currently out-of-date compared to apt repos?
###########################################################
$ sudo apt-get update

$ /usr/lib/update-notifier/apt-check --human-readable
5 packages can be updated.
5 updates are security updates.

$ /usr/lib/update-notifier/apt-check -p
firefox-locale-en
xul-ext-ubufox
firefox
vnc4server
linux-firmware

# ...TBD: confirm w/ Keith and Rob that these aren't intentionally being held in old state


###########################################################
# install missing command-line utilities
###########################################################
$ sudo apt-get install aptitude vim tree


###########################################################
# upgrade git to > 2.0 :
###########################################################
$ git --version
git version 1.9.1    # need git > 2.0
$ sudo apt-add-repository ppa:git-core/ppa
$ sudo apt-get update
$ sudo apt-get install git
$ git --version
git version 2.5.0


###########################################################
# install vcsh
###########################################################
# no action needed at system level, unless Keith and Rob want it system-wide (TBD: ask them):
$ ln -s ~/src.upstream.gitRepos/vcsh/vcsh ~/bin/


###########################################################
# install mr
###########################################################
$ cd /tmp
$ git clone git://myrepos.branchable.com/myrepos
$ cd myrepos/
$ sudo make install
$ which mr
/usr/bin/mr


###########################################################
# sync mr (my $HOME only...no action needed from Keith/Rob)
###########################################################
# vcsh repos failed because of existing files:
# vcsh-sdt-bash
# vcsh-sdt-iterm2
# vcsh-sdt-tmux
# vcsh-sdt-vim
cd ~
rm -f  .mrconfig
rm -fr .config/vcsh
rm -fr .config/mr
rm -fr .gitignore/mr

for vcshRepo in vcsh-sdt-bash vcsh-sdt-iterm2 vcsh-sdt-tmux vcsh-sdt-vim; do 
   vcsh ${vcshRepo} fetch --all
   vcsh ${vcshRepo} reset --hard origin/master
done

# re-sync from master:
vcsh clone https://github.com/stowler/mr.git mr
mr up
mr up


###########################################################
# terminal colors: (my $HOME only...nothing needed from Keith/Rob)
###########################################################
# added to ~/.extra_local:
# (TBD: build-in ~/.extra case statement that executes for linux only)
eval `dircolors ~/src.upstream.gitRepos/dircolors-solarized/dircolors.256dark`


###########################################################
# R (TBD version and libraries)
###########################################################
$ R --version
R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"
Copyright (C) 2013 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)


###########################################################
# MATLAB (TBD: install matlab)
###########################################################
$ matlab
matlab: command not found


###########################################################
# itksnap
###########################################################
# itksnap runs but itksnap3 crashes (only tested over ssh):
$ ls -al /usr/bin/
-rwxr-xr-x 1 root root 11649472 May 30  2012 /usr/bin/itksnap
-rwxr-xr-x 1 root root    77577 Aug  6 16:13 /usr/bin/itksnap3

$ itksnap3
Error converting runtime path entry "/usr/bin/../lib/snap-3.2.0" to real path: No such file or directory


###########################################################
# FSL (TBD: fix fsl)
###########################################################
# looks like FSL is only partially installed on Keith/Rob's image:
$ echo $FSLDIR # (nothing returned)

$ fslmaths
fslmaths: command not found

$ which fslview
/usr/bin/fslview


###########################################################
# FSL FIX
###########################################################
TBD: test after FSL and matlab are fixed


###########################################################
# FSL melview
###########################################################
TBD: test after FSL and matlab are fixed


###########################################################
# FSL ICA-AROMA
###########################################################
TBD: test after FSL and matlab are fixed


###########################################################
# FSLNets
###########################################################
TBD: test after FSL and matlab are fixed


###########################################################
# AFNI
###########################################################
# Installed AFNI is super old:
$ afni --version
Precompiled binary =Debian-x86_64-1-gnu: Dec 26 2014 (Version AFNI_2011_12_21_1014)

TBD: update AFNI and test further


###########################################################
# FBIRN tools
###########################################################
# FBIRN BXH/XCEDE tools are missing:
$ fmriqa_generate.pl
fmriqa_generate.pl: command not found

$ dicom2bxh
dicom2bxh: command not found


###########################################################
# FreeSurfer
###########################################################
$ recon-all
recon-all: command not found

$ freeview
No command 'freeview' found, did you mean:
 Command 'treeview' from package 'treeview' (multiverse)
 freeview: command not found

$ echo $FREESURFER_HOME # no value returned
$ echo $SUBJECTS_DIR    # no value returned


###########################################################
# MRIcron
###########################################################
# it's installed and launches without error:
$ which mricron
/usr/bin/mricron

$ dpkg -S /usr/bin/mricron
mricron: /usr/bin/mricron

#TBD: test actual image display


###########################################################
# MRIcroGL
###########################################################
# manually download mricrogl's lx.zip from nitrc.org
# TBD: where are you managing non-apt software? Nothing in /opt currently: 
$ ls -al /opt
total 8
drwxr-xr-x  2 root root 4096 Jul 23  2014 .
drwxr-xr-x 25 root root 4096 Apr 23 16:07 ..


###########################################################
# ImageJ / FIJI
###########################################################
TBD: test


###########################################################
# SPM
###########################################################
TBD: install and test after Keith/Rob install matlab







```


