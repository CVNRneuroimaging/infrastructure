# stowler BIRC system config: pano.birc.emory.edu on 20150818

_ongoing install/config/testing..._

# confirmed environment after upgrade to 14.04

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


# confirmed git

```bash
$ git --version
git version 2.3.5

$ git config --list
user.name=Stephen Towler
user.email=stowler@gmail.com
color.ui=auto
push.default=simple
```


# confirmed/upgraded vcsh/mr

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

$ mr up
```


# confirmed general command-line utilities

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


# configured R

## confirmed location of currently installed R libraries:

```
$ sudo R --no-save
> .libPaths()
[1] "/usr/local/lib/R/site-library" "/usr/lib/R/site-library"
[3] "/usr/lib/R/library"
```

## removed outdated R packages:

```bash
$ sudo apt-get autoremove r-base r-base-core r-base-dev r-doc-html
# ...after which I ran aptitude to detect and resolve any conflicts created by that command

$ sudo rm -fr /usr/local/lib/R/site-library /usr/lib/R/site-library /usr/lib/R/library

```

## updated apt sources and packages
...per R Ubuntu [README](http://cran.r-project.org/bin/linux/ubuntu/README.html):

```bash
# added the secure apt key:
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# added this line to /etc/apt/sources.list:
# deb http://cran.stat.ucla.edu/bin/linux/ubuntu trusty/

$ sudo apt-get update
$ sudo apt-get install r-base r-base-dev
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  r-base-core r-base-html r-cran-boot r-cran-class r-cran-cluster
  r-cran-codetools r-cran-foreign r-cran-kernsmooth r-cran-lattice r-cran-mass
  r-cran-matrix r-cran-mgcv r-cran-nlme r-cran-nnet r-cran-rpart
  r-cran-spatial r-cran-survival r-recommended
Suggested packages:
  ess r-doc-info r-doc-pdf r-mathlib texlive-fonts-recommended
  texlive-fonts-extra texinfo
The following NEW packages will be installed:
  r-base r-base-core r-base-dev r-base-html r-cran-boot r-cran-class
  r-cran-cluster r-cran-codetools r-cran-foreign r-cran-kernsmooth
  r-cran-lattice r-cran-mass r-cran-matrix r-cran-mgcv r-cran-nlme r-cran-nnet
  r-cran-rpart r-cran-spatial r-cran-survival r-recommended
0 upgraded, 20 newly installed, 0 to remove and 1 not upgraded.
Need to get 36.2 MB of archives.
After this operation, 56.6 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
```

## updated the installed packages from within R:

```
sudo R --no-save
update.packages(ask=FALSE, repos='http://cran.stat.ucla.edu')
q()
```

## installed R deps:

```bash
# rgl dependencies from apt sources:
sudo apt-get install xserver-xorg-dev libx11-dev libglu1-mesa-dev mesa-utils glew-utils

# Rcmdr dependencies from apt sources:
sudo apt-get install default-jre default-jdk unixodbc-dev
sudo R CMD javareconf

# RcmdrPlugin.HH dependencies from apt sources:
sudo apt-get install libgmp-dev libmpfr-dev
```

## compiled R packages and dependencies:

```
sudo R --no-save
install.packages('rgl',            dependencies=TRUE, repos='http://cran.stat.ucla.edu')
install.packages('car',            dependencies=TRUE, repos='http://cran.stat.ucla.edu')
install.packages('XLConnect',      dependencies=TRUE, repos='http://cran.stat.ucla.edu')
install.packages('Rcmdr',          dependencies=TRUE, repos='http://cran.stat.ucla.edu')
install.packages('RcmdrPlugin.HH', dependencies=TRUE, repos='http://cran.stat.ucla.edu')

```


## tested R 3D and GUI toolkits:

```
$ sudo R --no-save
> library(rgl)
> demo(rgl)
> library(car)
> library(Rcmdr)
# mouse:
#     1) Tools -> Load Rcmdr plug-ins... -> RcmdrPlugin.HH
#     2) Data -> Data in packages -> Read data set from an attached package... -> PACKAGE: datasets, DATA SET: mtcars
#     3) Data set: mtcars
#     4) Graphs -> 3d graph -> 3d scatterplot... (HH). DV: mpg, IVs: disp, hp.
#     5) Graphs -> 3d graph -> Identify observations with mouse...
```


# confirmed matlab

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


