# stowler BIRC system config: pano and rama on Sunday 20150823

_...config and testing in progress..._

Contents
=================

  * [pano\.birc\.emory\.edu](#panobircemoryedu)
  * [rama\.birc\.emory\.edu](#ramabircemoryedu)
    * [R: tested](#r-tested)
    * [FSL: configured and tested](#fsl-configured-and-tested)
    * [FSL FIX: installed](#fsl-fix-installed)


<!--
Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)
-->

# pano.birc.emory.edu

TBD

# rama.birc.emory.edu

## R: tested

Tested R, including its 3D and GUI toolkits. Everything works but per normal RGL is *super* slow over ssh forwarding.

```bash
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
#     5) Graphs -> 3d graph -> "Open new 3D grahics window", "Identify observations with mouse", "Show surface grid lines" 
#
# ...and the CLI version of steps 2-5:
> data(mtcars, package="datasets")
> scatter3dHH(mtcars$disp, mtcars$mpg, mtcars$hp, fit="linear", bg="white", grid=TRUE, squares=FALSE, xlab="disp", ylab="mpg", zlab="hp")
> Identify3d(mtcars$disp, mtcars$mpg, mtcars$hp, labels=row.names(mtcars))
> q()
```

## FSL: configured and tested 

Looks like some FSL packages have been installed via neurodebia apt:

```bash
[09:20:36]-[stowler-local]-at-[rama]-in-[~]
$ sudo apt list --installed | grep fsl
[sudo] password for stowler-local:

WARNING: apt does not have a stable CLI interface yet. Use with caution in scripts.

e2fslibs/trusty-updates,trusty-security,now 1.42.9-3ubuntu1.2 amd64 [installed]
fsl/trusty,now 5.0.8-3~nd14.04+1 all [installed]
fsl-5.0-core/trusty,now 5.0.8-3~nd14.04+1 amd64 [installed,automatic]
fsl-atlases/data,now 5.0.7-2 all [installed,automatic]
fsl-bangor-cerebellar-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-core/trusty,now 5.0.8-3~nd14.04+1 all [installed,automatic]
fsl-harvard-oxford-atlases/data,now 5.0.7-2 all [installed,automatic]
fsl-harvard-oxford-cortical-lateralized-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-jhu-dti-whitematter-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-juelich-histological-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-mni-structural-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-mni152-templates/data,now 5.0.7-2 all [installed,automatic]
fsl-oxford-striatal-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-oxford-thalamic-connectivity-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-resting-connectivity-parcellation-atlases/data,now 5.0.7-2 all [installed,automatic]
fsl-subthalamic-nucleus-atlas/data,now 5.0.7-2 all [installed,automatic]
fsl-talairach-daemon-atlas/data,now 5.0.7-2 all [installed,automatic]
fslview/trusty,now 4.0.1-2~nd13.04+1+nd13.10+1+nd14.04+1 amd64 [installed,automatic]
fslview-doc/trusty,now 4.0.1-2~nd13.04+1+nd13.10+1+nd14.04+1 all [installed,automatic]


[09:20:51]-[stowler-local]-at-[rama]-in-[~]
$ sudo apt-get install fsl-complete
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  fsl-5.0-complete fsl-first-data fsl-possum-data
Recommended packages:
  fsl-5.0-wiki fsl-5.0-gpu
The following NEW packages will be installed:
  fsl-5.0-complete fsl-complete fsl-first-data fsl-possum-data
0 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
Need to get 1,108 MB of archives.
After this operation, 1,202 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y

[09:30:09]-[stowler-local]-at-[rama]-in-[~]
$ sudo apt-get install fsl-feeds
```

FSL environment not setup yet:

```bash
[09:52:34]-[stowler-local]-at-[rama]-in-[~]
$ echo $FSLDIR

[09:56:46]-[stowler-local]-at-[rama]-in-[~]
$ echo ". /etc/fsl/5.0/fsl.sh" | sudo tee -a /etc/profile.d/birc_custom.sh
[sudo] password for stowler-local:
. /etc/fsl/5.0/fsl.sh

[09:57:24]-[stowler-local]-at-[rama]-in-[~]
$ cat /etc/profile.d/birc_custom.sh
. /etc/fsl/5.0/fsl.sh

[09:58:46]-[stowler-local]-at-[rama]-in-[~]
$ echo $FSLDIR
/usr/share/fsl/5.0
```

Install FEEDS system-wide:
```bash
$ cd Downloads
$ feedsVersion=5.0.8
$ tar -zxvf fsl-${feedsVersion}-feeds.tar.gz
$ sudo cp -a feeds /opt/feeds-${feedsVersion}
$ sudo ln -s /opt/feeds-${feedsVersion} /opt/feeds

# edited line 398 in file "RUN" to remove "DYLD_LIBRARY_PATH LD_LIBRARY_PATH"

# prevent users from accidentally overwriting system-wide FEEDS:
$ sudo chown -R root:root /opt/feeds-${feedsVersion}
$ echo "Do not run FEEDS from /opt. Instead: cp -R --dereference /opt/feeds /tmp/yourFeedsCopy" | sudo tee -a README-doNotRunFromOpt.txt
```

Run FSL self-test FEEDS:
```bash
$ cp -R --dereference /opt/feeds /tmp/myFeedsCopy

$ cd /tmp/myFeedsCopy

[10:13:59]-[stowler-local]-at-[rama]-in-[/tmp/myFeedsCopy]
$ /usr/bin/time ./RUN all

...snip...

All tests passed

end time = Sun Aug 23 10:42:39 EDT 2015

1503.78user 11.42system 28:30.08elapsed 88%CPU (0avgtext+0avgdata 988924maxresident)k
46264inputs+1055544outputs (85major+3480278minor)pagefaults 0swaps

[10:42:39]-[stowler-local]-at-[rama]-in-[/tmp/myFeedsCopy]
$
```

## FSL FIX: installed

Download, extracted, and install FIX 1.062:

```bash
# Download:
$ scp stowler-local@pano.birc.emory.edu:${HOME}/Downloads/fix.tar.gz .

# Check version:
$ head fix1.06/settings.sh
# Settings file for FIX
# Modify these settings based on your system setup
FIXVERSION=1.06
#   (actually this version is 1.062 - see wiki page for details)

# install system-wide:
$ fixVersion=1.062
$ sudo mv fix1.06 /opt/fix-${fixVersion}
$ sudo ln -s /opt/fix-${fixVersion} /opt/fix
```

Configure system-wide shell environment for FIX:
```bash
$ echo "export PATH=/opt/fix:${PATH}" | sudo tee -a /etc/profile.d/birc_custom.sh
$ echo $PATH
/home/stowler-local/src.mywork.gitRepos/brainwhere:/home/stowler-local/bin:/home/stowler-local/src.mywork.gitRepos/brainwhere:/home/stowler-local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/fsl/5.0
$ . /etc/profile.d/birc_custom.sh
$ echo $PATH
/opt/fix:/home/stowler-local/src.mywork.gitRepos/brainwhere:/home/stowler-local/bin:/home/stowler-local/src.mywork.gitRepos/brainwhere:/home/stowler-local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/fsl/5.0
```

Install R libraries for FIX:
```bash
$ sudo R --no-save
> install.packages("kernlab",      dependencies=TRUE, repos='http://cran.stat.ucla.edu')
> install.packages("ROCR",         dependencies=TRUE, repos='http://cran.stat.ucla.edu')
> install.packages("class",        dependencies=TRUE, repos='http://cran.stat.ucla.edu')
> install.packages("party",        dependencies=TRUE, repos='http://cran.stat.ucla.edu')
> install.packages("e1071",        dependencies=TRUE, repos='http://cran.stat.ucla.edu')
> install.packages("randomForest", dependencies=TRUE, repos='http://cran.stat.ucla.edu')
```

Edited FIX's `settings.sh` to reflect our MATLAB config:
```
FSL_FIX_MATLAB_MODE=1 # Matlab script mode
FSL_FIX_MATLAB_ROOT=/opt/MATLAB/R2015a
```

