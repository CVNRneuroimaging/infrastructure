# stowler BIRC system config: pano and rama on Wednesday 20150826

_config and testing in progress..._

Contents
=================


<!--
Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)
-->

# pano.birc.emory.edu

_Rob is trouble-shooting pano's display today, rebooting-at-will._

# rama.birc.emory.edu

## installed FBIRN tools

Installed lsb:
```bash
$ sudo apt-get install lsb
[sudo] password for stowler-local:
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required:
  libdbi1 librrd4 ntop-data python-mako
Use 'apt-get autoremove' to remove them.
The following extra packages will be installed:
  alien at debugedit lib32z1 libjpeg62 libpod-plainer-perl libqt4-sql-sqlite
  librpm3 librpmbuild3 librpmio3 librpmsign1 lsb-core lsb-cxx lsb-desktop
  lsb-graphics lsb-languages lsb-multimedia lsb-printing lsb-security pax rpm
  rpm-common rpm2cpio
Suggested packages:
  lsb-rpm rpm-i18n libqt4-dev elfutils
Recommended packages:
  libqt3-mt
The following NEW packages will be installed:
  alien at debugedit lib32z1 libjpeg62 libpod-plainer-perl libqt4-sql-sqlite
  librpm3 librpmbuild3 librpmio3 librpmsign1 lsb lsb-core lsb-cxx lsb-desktop
  lsb-graphics lsb-languages lsb-multimedia lsb-printing lsb-security pax rpm
  rpm-common rpm2cpio
0 upgraded, 24 newly installed, 0 to remove and 3 not upgraded.
Need to get 837 kB of archives.
After this operation, 3,874 kB of additional disk space will be used.
Do you want to continue? [Y/n]
```

Downloaded latest release from website:
```bash
[11:33:50]-[stowler-local]-at-[rama]-in-[~/src.mywork.gitRepos]
$ ls -altr ~/Downloads/bxh*
-rw-r----- 1 stowler-local stowler-local 56693856 Aug 26 11:33 /home/stowler-local/Downloads/bxh_xcede_tools-1.11.1-lsb30.x86_64.tgz

[11:33:56]-[stowler-local]-at-[rama]-in-[~/src.mywork.gitRepos]
$ md5sum ~/Downloads/bxh*
68adee55021af85075beed5656416f17  /home/stowler-local/Downloads/bxh_xcede_tools-1.11.1-lsb30.x86_64.tgz
```

Unpacked and installed to `/opt`. Edited `/etc/bash.bashrc` to include `$BXHDIR` and pre-pend to `$PATH`a

## installed AFNI

Packages were already installed but environment wasn't configured.

Added `. /etc/afni/afni.sh` to my `.extra_local` because system-wide setting wasn't working.
