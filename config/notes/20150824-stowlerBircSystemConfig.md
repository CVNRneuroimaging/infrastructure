# stowler BIRC system config: pano and rama on Monday 20150824

_config and testing in progress..._

Contents
=================

  * [pano\.birc\.emory\.edu](#panobircemoryedu)
    * [backed\-up to hippoback](#backed-up-to-hippoback)
    * [gridengine: installed for single\-host parallel processing](#gridengine-installed-for-single-host-parallel-processing)
    * [gridengine: configured FSL work\-around](#gridengine-configured-fsl-work-around)
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

## gridengine: configured FSL work-around

Neurodebian on our Ubuntu 14.04 hosts turns our to have broken FSL parallelization. Normally setting these two parameters in `/etc/fsl/fsl.sh` would enable FSL's `fsl_sub` to do it's work:

```bash
FSLPARALLEL=1
FSLCLUSTER_DEFAULT_QUEUE="mainqueue" #...the name of the sole queue I configured on pano for quick and dirty setup
```

...but in our environment `fsl_sub` isn't getting those parameters from `fsl.sh` for some reason. 

Once I realized that was the problem I just hard-coded those values into `fsl_sub`:

```bash
...snip...

 # from Stephen: doesn't look like this is making it from fsl.sh:
  FSLPARALLEL=1
  # Allow to override the above automatic detection result with FSLPARALLEL
  if [ -n "$FSLPARALLEL" ] ; then

...snip...

# from Stephen: looks like this isn't making it from fsl.sh:

  FSLCLUSTER_DEFAULT_QUEUE="mainqueue"
  # SGE should already have a default queue, but allow for overwrite
  queueCmd=""
  if [ "x$FSLCLUSTER_DEFAULT_QUEUE" != "x" ] ; then

...snip...

map_qname ()
  {
     # for Debian we can't do the stuff below, because it would be hard
     # to determine how particular queues are meant to be used on any given
     # system. Instead of translating into a queue name we specify proper
     # resource limits, and let SGE decide what queue matches
     # (qsub wants the time limit in seconds)
     queueCmd="$queueCmd -l h_rt=$(echo "$1 * 60" | bc)"
      if [ $1 -le 20 ] ; then
        #queue=veryshort.q
        queue=mainqueue
      elif [ $1 -le 120 ] ; then
        #queue=short.q
        queue=mainqueue
      elif [ $1 -le 1440 ] ; then
        #queue=long.q
        queue=mainqueue
      else
        #queue=verylong.q
        queue=mainqueue
      fi
      queueCmd=" -q $queue "

      #echo "Estimated time was $1 mins: queue name is $queue"
  }
```

## gridengine: test on MELODIC group ICA

```bash
[14:37:31]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ tar -xvf melFromFeeds-afterFix.tar

# Use Melodic GUI to load my existing gica .fsf file for FIX-cleaned data
# (was created during execution of non-parallel Melodic)
[14:40:10]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ find /data/panolocal/tempStowler/resultsGroupICA/ | grep fsf | xargs ls -al
-rw-rw-r-- 1 stowler-local stowler-local 23840 Aug 21 07:51 /data/panolocal/tempStowler/resultsGroupICA/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica/design.fsf
-rw-rw-r-- 1 stowler-local stowler-local 23482 Aug 22 03:40 /data/panolocal/tempStowler/resultsGroupICA/melFromFeeds-groupICA-inputsUncleaned-temporalCat-structBBR-standard2mmNonlinear.gica/design.fsf

# ...but had to enter a regenerated list of fix-cleaned inputs using:
#  https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/tests-melodicAndFix-201508/melFromFeeds-generateList-filtered_func_data.sh

# monitoring gica progress with script:
[14:53:56]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ bwMelodicProgress.sh /tmp/melFromFeeds-groupICA-FSLPARALLEL-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Progress of the melodic creating output in /tmp/melFromFeeds-groupICA-FSLPARALLEL-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica:
drwxrwxr-x 5 stowler-local stowler-local 4096 Aug 24 14:50 /tmp/melFromFeeds-groupICA-FSLPARALLEL-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Melodic Started at Mon Aug 24 14:50:12 EDT 2015 :
884K    /tmp/melFromFeeds-groupICA-FSLPARALLEL-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
...but melodic not yet finished as of Mon Aug 24 14:54:13 EDT 2015. Will check again in 20 seconds...

...snip...
```



# rama.birc.emory.edu

## gridengine: install for single-host parallel processing

TBD: will install after testing parallel MELODIC on pano because it is possible that will need to use son of grid engine rather than ubuntu 14.04's default gridengine.

## gridengine: test on MELODIC group ICA

TBD
