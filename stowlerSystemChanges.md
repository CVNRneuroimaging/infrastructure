# stowlerSystemChanges.md

_Changes I made to Keith's installed BIRC systems in preparation for group maintenance and rev/redeployment of BIRC system image._

# Wed, 20150922

## deployed and tested on qball4:

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
# upgrade git to > 2.0 :
###########################################################
$ git --version
git version 1.9.1    # need git > 2.0
$ sudo apt-add-repository ppa:git-core/ppa
$ sudo apt-get update
$ sudo apt-get install git
$ git --version
git version 2.5.0


$ sudo apt-get install aptitude vim tree


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
# sync mr (just my homedir...no action needed from Keith/Rob)
###########################################################
# need to clean-up from old links that reference /netusers:
cd ~
rm -f  .mrconfig
rm -fr .config/vcsh
rm -fr .config/mr
rm -fr .gitignore/mr

# re-sync from master:
vcsh clone https://github.com/stowler/mr.git mr

# vcsh repos failed because of existing files:
# vcsh-sdt-bash
# vcsh-sdt-iterm2
# vcsh-sdt-tmux
# vcsh-sdt-vim
for vcshRepo in vcsh-sdt-bash vcsh-sdt-iterm2 vcsh-sdt-tmux vcsh-sdt-vim; do vcsh ${vcshRepo} fetch --all; vcsh ${vcshRepo} reset --hard origin/master; done
mr up


###########################################################
# R
###########################################################
$ R --version
R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"
Copyright (C) 2013 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)



```


