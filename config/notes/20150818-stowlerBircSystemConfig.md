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

# tested FSL

Looks like all FSL packages have been installed via neurodebian apt:

```bash
$ apt list --installed | grep fsl

WARNING: apt does not have a stable CLI interface yet. Use with caution in scripts.

e2fslibs/trusty-updates,trusty-security,now 1.42.9-3ubuntu1.2 amd64 [installed]
fsl/now 5.0.8-3~nd12.04+1 all [installed,local]
fsl-5.0/now 5.0.8-3~nd12.04+1 all [installed,local]
fsl-5.0-complete/now 5.0.7-1~nd12.04+1 all [installed,local]
fsl-5.0-core/now 5.0.8-3~nd12.04+1 amd64 [installed,local]
fsl-atlases/now 5.0.7-1 all [installed,local]
fsl-bangor-cerebellar-atlas/now 5.0.7-1 all [installed,local]
fsl-complete/now 5.0.7-1~nd12.04+1 all [installed,local]
fsl-core/now 5.0.8-3~nd12.04+1 all [installed,local]
fsl-feeds/now 5.0.4-1 all [installed,local]
fsl-first-data/now 5.0.7-1 all [installed,local]
fsl-harvard-oxford-atlases/now 5.0.7-1 all [installed,local]
fsl-harvard-oxford-cortical-lateralized-atlas/now 5.0.7-1 all [installed,local]
fsl-jhu-dti-whitematter-atlas/now 5.0.7-1 all [installed,local]
fsl-juelich-histological-atlas/now 5.0.7-1 all [installed,local]
fsl-mni-structural-atlas/now 5.0.7-1 all [installed,local]
fsl-mni152-templates/now 5.0.7-1 all [installed,local]
fsl-neurosynth-atlas/now 0.0.20130328-1 all [installed,local]
fsl-neurosynth-top100-atlas/now 0.0.20130328-1 all [installed,local]
fsl-oxford-striatal-atlas/now 5.0.7-1 all [installed,local]
fsl-oxford-thalamic-connectivity-atlas/now 5.0.7-1 all [installed,local]
fsl-possum-data/now 5.0.7-1 all [installed,local]
fsl-resting-connectivity-parcellation-atlases/now 5.0.7-1 all [installed,local]
fsl-subthalamic-nucleus-atlas/now 5.0.7-1 all [installed,local]
fsl-talairach-daemon-atlas/now 5.0.7-1 all [installed,local]
fslview/now 4.0.1-2~nd12.04+1 amd64 [installed,local]
fslview-doc/now 4.0.1-2~nd12.04+1 all [installed,local]
```

FSL initialization script is still present in `/etc/bash.bashrc`: `. /etc/fsl/5.0/fsl.sh`. FSL environmental variables still active:

```bash
$ echo $FSLDIR
/usr/share/fsl/5.0
```


Adjusted file/dir permissions, extracted FSL FEEDS:

```bash
sudo chmod -R a+r /data/backup/Atlanta/stowlerWIP/neuroSoftware
sudo mkdir /data/panolocal/tempStowler
sudo chown stowler-local /data/panolocal/tempStowler
cd /data/panolocal/tempStowler
tar -zxvf /data/backup/Atlanta/stowlerWIP/neuroSoftware/fsl/fsl-current-20150115/fsl-5.0.8-feeds.tar.gz
```

Ran fsl self-test on external drive mounted as `/data/panolocal`:

```bash
$ cat /etc/mtab | grep panolocal
/dev/sdb1 /data/panolocal ext4 rw 0 0
cd  /data/panolocal/tempStowler/feeds
# removed "DYLD_LIBRARY_PATH LD_LIBRARY_PATH" from line 398 in RUN

[05:03:31]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler/feeds]
$ /usr/bin/time ./RUN all


FSL Evaluation and Example Data Suite v5.0.8

start time = Tue Aug 18 17:03:37 EDT 2015
hostname = pano.birc.emory.edu
os = Linux pano.birc.emory.edu 3.13.0-61-generic #100-Ubuntu SMP Wed Jul 29 11:21:34 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux


/bin/rm -rf /data/panolocal/tempStowler/feeds/results ; mkdir /data/panolocal/tempStowler/feeds/results

# ...snip...

All tests passed

end time = Tue Aug 18 17:31:25 EDT 2015

1461.02user 17.92system 27:47.72elapsed 88%CPU (0avgtext+0avgdata 986152maxresident)k
2504inputs+1055408outputs (11major+4263099minor)pagefaults 0swaps
```


Ran fsl self-test on internal drive to confirm that we're not handicapping ourselves with speed of external drive:

```bash
mkdir /tmp/stowlerFeeds
cd /tmp/stowlerFeeds
tar -zxvf /data/backup/Atlanta/stowlerWIP/neuroSoftware/fsl/fsl-current-20150115/fsl-5.0.8-feeds.tar.gz
cd feeds
# removed "DYLD_LIBRARY_PATH LD_LIBRARY_PATH" from line 398 in RUN

[06:35:05]-[stowler-local]-at-[pano]-in-[/tmp/stowlerFeeds/feeds]
$ /usr/bin/time ./RUN all

FSL Evaluation and Example Data Suite v5.0.8

start time = Tue Aug 18 18:35:18 EDT 2015
hostname = pano.birc.emory.edu
os = Linux pano.birc.emory.edu 3.13.0-61-generic #100-Ubuntu SMP Wed Jul 29 11:21:34 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux


/bin/rm -rf /tmp/stowlerFeeds/feeds/results ; mkdir /tmp/stowlerFeeds/feeds/results

# ...snip...

All tests passed

end time = Tue Aug 18 19:03:05 EDT 2015

1460.89user 17.78system 27:46.81elapsed 88%CPU (0avgtext+0avgdata 986152maxresident)k
0inputs+1055360outputs (0major+4285392minor)pagefaults 0swaps
```
