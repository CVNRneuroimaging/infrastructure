# stowler BIRC system config: pano and rama on Monday 20150824

_config and testing in progress..._

Contents
=================

  * [pano\.birc\.emory\.edu](#panobircemoryedu)
    * [backed\-up to hippoback](#backed-up-to-hippoback)
    * [gridengine: installed for single\-host parallel processing](#gridengine-installed-for-single-host-parallel-processing)
    * [gridengine: test on MELODIC group ICA](#gridengine-test-on-melodic-group-ica)
  * [rama\.birc\.emory\.edu](#ramabircemoryedu)
    * [gridengine: install for single\-host parallel processing](#gridengine-install-for-single-host-parallel-processing)
    * [gridengine: test on MELODIC group ICA](#gridengine-test-on-melodic-group-ica-1)


<!--
Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)
-->

# pano.birc.emory.edu

## backed-up to hippoback

```bash
stowler-local@hippoback:~$ cd /data/backup/Atlanta/stowlerxfer082115/
stowler-local@hippoback:/data/backup/Atlanta/stowlerxfer082115$ ls
data
stowler-local@hippoback:/data/backup/Atlanta/stowlerxfer082115$ rsync -avR --progress stowler-local@pano.birc.emory.edu:/data/panolocal .
```

## gridengine: installed for single-host parallel processing

Roughly followed [this guide] for installation and initial testing. Ubuntu 14.04 has known GUI bugs for this package (`Warning: Cannot convert string "intro" to type Pixmap`, etc.), but so far I've been able to get around them using the menus.

Added `FSLPARALLEL=1` to `/etc/fsl/fsl.sh`.

[this guide]: https://scidom.wordpress.com/2012/01/18/sge-on-single-pc/

## gridengine: test on MELODIC group ICA





# rama.birc.emory.edu

## gridengine: install for single-host parallel processing

TBD: will install after testing parallel MELODIC on pano because it is possible that will need to use son of grid engine rather than ubuntu 14.04's default gridengine.

## gridengine: test on MELODIC group ICA

TBD
