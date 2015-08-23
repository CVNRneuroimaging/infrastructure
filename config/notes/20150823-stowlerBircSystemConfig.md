# stowler BIRC system config: pano and rama on Sunday 20150823

_...config and testing in progress..._

Contents
=================

  * [pano\.birc\.emory\.edu](#panobircemoryedu)
  * [rama\.birc\.emory\.edu](#ramabircemoryedu)
    * [FSL: config and test](#fsl-config-and-test)

<!--
Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)
-->

# pano.birc.emory.edu

TBD

# rama.birc.emory.edu

## FSL: config and test

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

# On some linux installs the user may need to remove
# "DYLD_LIBRARY_PATH LD_LIBRARY_PATH" from line 398 in file "RUN"
# (confirmed in FSL 5.0.7 and 5.0.8 running on neurodebian ubuntu 12.04 and 14.04)

$ cd /tmp/myFeedsCopy

[10:13:59]-[stowler-local]-at-[rama]-in-[/tmp/myFeedsCopy]
$ /usr/bin/time ./RUN all
```

