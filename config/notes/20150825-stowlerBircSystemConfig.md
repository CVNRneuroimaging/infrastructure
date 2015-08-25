# stowler BIRC system config: pano and rama on Tuesday 20150825

_config and testing in progress..._

Contents
=================

  * [pano\.birc\.emory\.edu](#panobircemoryedu)
    * [ssh key management](#ssh-key-management)
    * [backed\-up to hippoback, rebooted](#backed-up-to-hippoback-rebooted)
  * [rama\.birc\.emory\.edu](#ramabircemoryedu)
    * [ssh key management](#ssh-key-management-1)
    * [gridengine: configured FSL work\-around](#gridengine-configured-fsl-work-around)
    * [gridengine: test on MELODIC group ICA](#gridengine-test-on-melodic-group-ica)
    * [melview: installed and tested](#melview-installed-and-tested)

<!--
Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)
-->

# pano.birc.emory.edu

## ssh key management

Cleaned up outdated ssh keys, distributed current public keys for stowler-local. (More efficient logins and transfers).

## backed-up to hippoback, rebooted

```bash
# pano console locked up again, so backed-up prior to reboot

[13:32:43]-[stowler-local]-at-[pano]-in-[~]
$ mv /tmp/melFromFeeds-groupICA-FSLPARALLEL-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica /data/panolocal/tempStowler/resultsGroupICA/

[13:33:35]-[stowler-local]-at-[pano]-in-[~]
$ sync


stowler-local@hippoback:~$ cd /data/backup/Atlanta/stowlerxfer082115/
stowler-local@hippoback:/data/backup/Atlanta/stowlerxfer082115$ ls
data
stowler-local@hippoback:/data/backup/Atlanta/stowlerxfer082115$ rsync -avR --progress stowler-local@pano.birc.emory.edu:/data/panolocal .

```



# rama.birc.emory.edu

## ssh key management

Cleaned up outdated ssh keys, distributed current public keys for stowler-local. (More efficient logins and transfers).

## gridengine: configured FSL work-around

Edited `fsl_sub` directly per yesterday's finding on pano:

```bash
...snip...


# ST, 20150825: Doesn't look like $FSLPARALLEL is getting imported from fsl.sh, so...
  FSLPARALLEL=1
  # Allow to override the above automatic detection result with FSLPARALLEL
  if [ -n "$FSLPARALLEL" ] ; then

...snip...

 # stowler, 20150825: Doesn't look like $FSLCLUSTER_DEFAULT_QUEUE is getting imported from fsl.sh, so...
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

Copied files from pano to duplicate yesterday's testing. Topped out at about 80 MB/s, mean 35-40:
```bash
[14:25:08]-[stowler-local]-at-[pano]-in-[/data/panolocal]
$ du -sh /data/panolocal/tempStowler
50G	/data/panolocal/tempStowler

[14:26:33]-[stowler-local]-at-[rama]-in-[~]
$ rsync -av --progress stowler-local@pano:/data/panolocal/tempStowler /data/panolocal/

...snip...

sent 1,435,434 bytes  received 53,391,203,622 bytes  34,480,231.87 bytes/sec
total size is 53,373,585,489  speedup is 1.00

[14:53:25]-[stowler-local]-at-[rama]-in-[~]
$
```

...prep to run...
```bash
[15:55:15]-[stowler-local]-at-[rama]-in-[/data/panolocal/tempStowler]
$ rm -fr fixThresh*

[15:55:40]-[stowler-local]-at-[rama]-in-[/data/panolocal/tempStowler]
$ tar -xvf melFromFeeds-afterFix.tar

# Use Melodic GUI to load my existing gica .fsf file for FIX-cleaned data
# (was created during execution of non-parallel Melodic)
[15:55:40]-[stowler-local]-at-[rama]-in-[/data/panolocal/tempStowler]
$ find /data/panolocal/tempStowler/resultsGroupICA/ | grep fsf | xargs ls -al
-rw-rw-r-- 1 stowler-local stowler-local 24284 Aug 24 17:10 /data/panolocal/tempStowler/resultsGroupICA/melFromFeeds-groupICA-FSLPARALLEL-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica/design.fsf
-rw-rw-r-- 1 stowler-local stowler-local 23840 Aug 21 07:51 /data/panolocal/tempStowler/resultsGroupICA/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica/design.fsf
-rw-rw-r-- 1 stowler-local stowler-local 23482 Aug 22 03:40 /data/panolocal/tempStowler/resultsGroupICA/melFromFeeds-groupICA-inputsUncleaned-temporalCat-structBBR-standard2mmNonlinear.gica/design.fsf

# ...but had to enter a regenerated list of fix-cleaned inputs using:
#  https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/tests-melodicAndFix-201508/melFromFeeds-generateList-filtered_func_data.sh
```

...reboot because console has died again...
```bash
[16:09:39]-[stowler-local]-at-[rama]-in-[~]
$ sudo shutdown -r now

# each rama reboot takes about 10 minutes:

[16:19:26]-[stowler-local]-at-[rama]-in-[~]
$
```

...launch via Melodic GUI, then monitor:
```bash

# after gica launch, htop shows all 24 cores at 100%. Good sign.

[16:57:05]-[stowler-local]-at-[rama]-in-[/data/panolocal/tempStowler]
$ bwMelodicProgress.sh /tmp/melFromFeeds-groupICA-FSLPARALLELrama-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Progress of the melodic creating output in /tmp/melFromFeeds-groupICA-FSLPARALLELrama-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica:
drwxrwxr-x 5 stowler-local stowler-local 4096 Aug 25 16:56 /tmp/melFromFeeds-groupICA-FSLPARALLELrama-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Melodic Started at Tue Aug 25 16:56:31 EDT 2015 :
1008K   /tmp/melFromFeeds-groupICA-FSLPARALLELrama-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
...but melodic not yet finished as of Tue Aug 25 16:57:16 EDT 2015. Will check again in 20 seconds...

```

## melview: installed and tested

Installed and tested melview. Recorded [commands and stdout][] for future troubleshooting.

[commands and stdout]: https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/notes/20150825-stowlerInstalledMelviewOnRama.md
