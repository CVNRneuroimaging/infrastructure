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

Keith responded to my [ticket](https://github.com/CVNRneuroimaging/infrastructure/issues/144): he and Rob haven't configured SGE for their Ubuntu 14.04 lab deployments. 

So I installed the gridengine packages from the native repos. It turns out Ubuntu 14.04 has known GUI bugs for this package (`Warning: Cannot convert string "intro" to type Pixmap`, etc.), but so far I've been able to get around them using the menus.


```
[09:08:59]-[stowler-local]-at-[rama]-in-[~/src.mywork.gitRepos/brainwhere/utilitiesAndData/testsForFSL] on master [?]
$ sudo apt-get install gridengine-master gridengine-exec gridengine-client gridengine-qmon gridengine-common
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  bsd-mailx postfix xfonts-75dpi
Suggested packages:
  procmail postfix-mysql postfix-pgsql postfix-ldap postfix-pcre sasl2-bin
  dovecot-common postfix-cdb postfix-doc
The following NEW packages will be installed:
  bsd-mailx gridengine-client gridengine-common gridengine-exec
  gridengine-master gridengine-qmon postfix xfonts-75dpi
0 upgraded, 8 newly installed, 0 to remove and 0 not upgraded.
Need to get 12.8 MB of archives.
After this operation, 57.3 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
```

Then I roughly followed [this guide] for installation and initial testing.

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

Same approach as rama install (see above):

```bash
[21:51:13]-[stowler-local]-at-[rama]-in-[/tmp]
$ sudo apt-get install gridengine-master gridengine-exec gridengine-client gridengine-qmon gridengine-common
[sudo] password for stowler-local:
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  bsd-mailx postfix xfonts-75dpi
Suggested packages:
  procmail postfix-mysql postfix-pgsql postfix-ldap postfix-pcre sasl2-bin
  dovecot-common postfix-cdb postfix-doc
The following NEW packages will be installed:
  bsd-mailx gridengine-client gridengine-common gridengine-exec
  gridengine-master gridengine-qmon postfix xfonts-75dpi
0 upgraded, 8 newly installed, 0 to remove and 0 not upgraded.
Need to get 12.8 MB of archives.
After this operation, 57.3 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
```

- Postfix: none
- SGE cell: default
- SGE master host name: rama.birc.emory.edu

postfix messages:

```bash
# ...snip...
Setting up postfix (2.11.0-1ubuntu1) ...
Adding group `postfix' (GID 126) ...
Done.
Adding system user `postfix' (UID 118) ...
Adding new user `postfix' (UID 118) with group `postfix' ...
Not creating home directory `/var/spool/postfix'.
Creating /etc/postfix/dynamicmaps.cf
Adding tcp map entry to /etc/postfix/dynamicmaps.cf
Adding sqlite map entry to /etc/postfix/dynamicmaps.cf
Adding group `postdrop' (GID 127) ...
Done.
/etc/aliases does not exist, creating it.

Postfix was not set up.  Start with
  cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf
.  If you need to make changes, edit
/etc/postfix/main.cf (and others) as needed.  To view Postfix configuration
values, see postconf(1).

After modifying main.cf, be sure to run '/etc/init.d/postfix reload'.

Setting up xfonts-75dpi (1:1.0.3) ...
Processing triggers for ufw (0.34~rc-0ubuntu2) ...
Processing triggers for ureadahead (0.100.0-16) ...
Setting up bsd-mailx (8.1.2-0.20131005cvs-1ubuntu0.14.04.1) ...
update-alternatives: using /usr/bin/bsd-mailx to provide /usr/bin/mailx (mailx) in auto mode
```

Initialization messages:

```bash
Initializing cluster with the following parameters:
 => SGE_ROOT: /var/lib/gridengine
 => SGE_CELL: default
 => Spool directory: /var/spool/gridengine/spooldb
 => Initial manager user: sgeadmin
Initializing spool (/var/spool/gridengine/spooldb)
Initializing global configuration based on /usr/share/gridengine/default-configuration
Initializing complexes based on /usr/share/gridengine/centry
Initializing usersets based on /usr/share/gridengine/usersets
Adding user sgeadmin as a manager
Cluster creation complete
Setting up gridengine-qmon (6.2u5-7.3) ...
Processing triggers for libc-bin (2.19-0ubuntu6.6) ...
Processing triggers for ureadahead (0.100.0-16) ...
```

Is it running? Yes:
```bash
[22:05:29]-[stowler-local]-at-[rama]-in-[/tmp]
$ ps aux | grep sge
sgeadmin 30785  0.2  0.0  62624  3636 ?        Sl   22:05   0:01 /usr/lib/gridengine/sge_execd
sgeadmin 30846  0.0  0.0 147276  7216 ?        Sl   22:05   0:00 /usr/lib/gridengine/sge_qmaster
stowler+ 30910  0.0  0.0  18936  2232 pts/22   S+   22:12   0:00 grep sge
```

Couldn't launch `qmon` over ssh forwarding, so I rebooted, after which I was able to launch `qmon` over ssh forwarding.

Got hostname-related errors:

```bash
[23:06:45]-[stowler-local]-at-[rama]-in-[~]
$ qstat
error: commlib error: access denied (client IP resolved to host name "localhost". This is not identical to clients host name "rama.birc.emory.edu")
error: unable to contact qmaster using port 6444 on host "rama.birc.emory.edu"

[23:08:56]-[stowler-local]-at-[rama]-in-[~]
$ cat /etc/hosts
127.0.0.1	localhost
127.0.1.1	rama.birc.emory.edu	rama
...snip...
```

...so I edited /etc/hosts and rebooted:

```bash
[23:12:41]-[stowler-local]-at-[rama]-in-[~]
$ cat /etc/hosts
127.0.0.1       localhost.localdomain   localhost
10.231.5.149    rama.birc.emory.edu     rama

[23:12:45]-[stowler-local]-at-[rama]-in-[~]
$ sudo shutdown -r now
```

Launched `sudo qmon` over ssh forwarding. Immediately after launch it seems to stop itself and must be resumed with `fg`.

Just like on the console, display errors prevent much of the GUI from being visible, so I configured according to the screenshots in [this article](https://scidom.wordpress.com/2012/01/18/sge-on-single-pc/).



## gridengine: test on MELODIC group ICA

TBD
