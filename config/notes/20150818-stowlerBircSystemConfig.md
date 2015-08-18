# stowler BIRC system config: pano.birc.emory.edu on 20150818

_More install/config/testing to be done but this is what I completed today._

# confirm platform after upgrade to 14.04

```bash
$ uname -a
Linux pano.birc.emory.edu 3.13.0-61-generic #100-Ubuntu SMP Wed Jul 29 11:21:34 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

$ lsb_release -a
LSB Version:	core-2.0-amd64:core-2.0-noarch:core-3.0-amd64:core-3.0-noarch:core-3.1-amd64:core-3.1-noarch:core-3.2-amd64:core-3.2-noarch:core-4.0-amd64:core-4.0-noarch:core-4.1-amd64:core-4.1-noarch:cxx-3.0-amd64:cxx-3.0-noarch:cxx-3.1-amd64:cxx-3.1-noarch:cxx-3.2-amd64:cxx-3.2-noarch:cxx-4.0-amd64:cxx-4.0-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-3.1-amd64:desktop-3.1-noarch:desktop-3.2-amd64:desktop-3.2-noarch:desktop-4.0-amd64:desktop-4.0-noarch:desktop-4.1-amd64:desktop-4.1-noarch:graphics-2.0-amd64:graphics-2.0-noarch:graphics-3.0-amd64:graphics-3.0-noarch:graphics-3.1-amd64:graphics-3.1-noarch:graphics-3.2-amd64:graphics-3.2-noarch:graphics-4.0-amd64:graphics-4.0-noarch:graphics-4.1-amd64:graphics-4.1-noarch:languages-3.2-amd64:languages-3.2-noarch:languages-4.0-amd64:languages-4.0-noarch:languages-4.1-amd64:languages-4.1-noarch:multimedia-3.2-amd64:multimedia-3.2-noarch:multimedia-4.0-amd64:multimedia-4.0-noarch:multimedia-4.1-amd64:multimedia-4.1-noarch:printing-3.2-amd64:printing-3.2-noarch:printing-4.0-amd64:printing-4.0-noarch:printing-4.1-amd64:printing-4.1-noarch:qt4-3.1-amd64:qt4-3.1-noarch:security-4.0-amd64:security-4.0-noarch:security-4.1-amd64:security-4.1-noarch
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.3 LTS
Release:	14.04
Codename:	trusty

$ echo $PATH
/home/stowler-local/src.mywork.gitRepos/brainwhere:/home/stowler-local/bin:/usr/share/centrifydc/bin:/opt/PanTrack:/opt/fix:/netusers/stowler/src.mywork.gitRepos/brainwhere:/opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/usr/share/fsl/5.0/bin:/opt/freesurfer/mni/bin:/opt/bxh/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/fsl/5.0:/usr/lib/afni/bin
```


# confirm git

```bash
$ git --version
git version 2.3.5

$ git config --list
user.name=Stephen Towler
user.email=stowler@gmail.com
color.ui=auto
push.default=simple
```


# confirm/upgrade vcsh/mr

```bash
$ which vcsh | xargs ls -al
lrwxrwxrwx 1 root root 51 Feb 20 22:26 /usr/local/bin/vcsh -> /home/stowler-local/src.upstream.gitRepos/vcsh/vcsh

$ which mr | xargs ls -al
-rwxr-xr-x 1 root root 58114 Feb 20 22:33 /usr/bin/mr

$ cd ~/src.upstream.gitRepos/myrepos/

$ sudo make install
[sudo] password for stowler-local:
Sorry, try again.
[sudo] password for stowler-local:
pod2man -c mr mr > mr.1
install -d /usr/bin
install -d /usr/share/man/man1
install -d /usr/share/mr
install -m0755 mr /usr/bin/
install -m0755 webcheckout /usr/bin/
install -m0644 mr.1 /usr/share/man/man1/
install -m0644 webcheckout.1 /usr/share/man/man1/
install -m0644 lib/* /usr/share/mr/

mr up
```


# confirm general command-line utilities

```bash
$ which curl wget tmux tree htop slurm vim aptitude convert
/usr/bin/curl
/usr/bin/wget
/usr/bin/tmux
/usr/bin/tree
/usr/bin/htop
/usr/bin/slurm
/usr/bin/vim
/usr/bin/aptitude
/opt/bxh/bin/convert
```


# configure R

```bash

```

# confirm matlab

```
>> ver
----------------------------------------------------------------------------------------------------
MATLAB Version: 8.5.0.197613 (R2015a)
MATLAB License Number: 300274
Operating System: Linux 3.13.0-61-generic #100-Ubuntu SMP Wed Jul 29 11:21:34 UTC 2015 x86_64
Java Version: Java 1.7.0_60-b19 with Oracle Corporation Java HotSpot(TM) 64-Bit Server VM mixed mode
----------------------------------------------------------------------------------------------------
MATLAB                                                Version 8.5        (R2015a)
Bioinformatics Toolbox                                Version 4.5.1      (R2015a)
Database Toolbox                                      Version 5.2.1      (R2015a)
Image Processing Toolbox                              Version 9.2        (R2015a)
MATLAB Coder                                          Version 2.8        (R2015a)
MATLAB Compiler                                       Version 6.0        (R2015a)
MATLAB Compiler SDK                                   Version 6.0        (R2015a)
Signal Processing Toolbox                             Version 7.0        (R2015a)
Statistics and Machine Learning Toolbox               Version 10.0       (R2015a)
>> 
```


