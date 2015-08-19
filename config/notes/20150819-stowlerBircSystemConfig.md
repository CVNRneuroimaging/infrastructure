# stowler BIRC system config: pano.birc.emory.edu on 20150819

_config and testing in progress..._

# tested Melodic in prep for testing FIX

Testing Melodic using FSL FEED's `fmri.nii.gz`, `structural.nii.gz`, and `structural_brain.nii.gz`.

For remote monitoring without web browser (i.e., "Progress Watcher" off in Melodic GUI), using my script [bwMelodicProgress.sh](https://github.com/stowler/brainwhere/blob/master/bwMelodicProgress.sh).

## tested melodic with no registration to standard template

Iterating over epi2struct registration methods: 6 dof, 7 dof, 12 dof, or BBR.

```
/tmp/melFromFeeds-struct6dof-standardNone.ica
7 minutes:
Started at Wed Aug 19 07:57:51 EDT 2015
Finished at Wed Aug 19 08:05:03 EDT 2015

/tmp/melFromFeeds-struct7dof-standardNone.ica
8 minutes:
Started at Wed Aug 19 08:25:44 EDT 2015
Finished at Wed Aug 19 08:33:28 EDT 2015

/tmp/melFromFeeds-struct12dof-standardNone.ica
8 minutes:
Started at Wed Aug 19 11:46:28 EDT 2015
Finished at Wed Aug 19 11:53:33 EDT 2015

/tmp/melFromFeeds-structBBR-standardNone.ica
14 minutes:
Started at Wed Aug 19 08:35:22 EDT 2015
Finished at Wed Aug 19 08:48:48 EDT 2015

```

## tested melodic with linear only registration to standard template

Iterating over epi2struct registration methods: 6 dof, 7 dof, 12 dof, or BBR.

```
/tmp/melFromFeeds-struct6dof-standard2mmLinear.ica
8 minutes:
Started at Wed Aug 19 08:59:13 EDT 2015
Finished at Wed Aug 19 09:06:57 EDT 2015

/tmp/melFromFeeds-struct7dof-standard2mmLinear.ica
8 minutes:
Started at Wed Aug 19 09:27:41 EDT 2015
Finished at Wed Aug 19 09:35:45 EDT 2015

/tmp/melFromFeeds-struct12dof-standard2mmLinear.ica
8 minutes:
Started at Wed Aug 19 11:36:04 EDT 2015
Finished at Wed Aug 19 11:44:02 EDT 2015

/tmp/melFromFeeds-structBBR-standard2mmLinear.ica
15 minutes:
Started at Wed Aug 19 09:40:26 EDT 2015
Finished at Wed Aug 19 09:55:01 EDT 2015
```

## tested melodic with nonlinear registration to standard template

Iterating over epi2struct registration methods: 6 dof, 7 dof, 12 dof, or BBR.

```
/tmp/melFromFeeds-struct6dof-standard2mmNonlinear.ica
16 minutes:
Started at Wed Aug 19 09:58:45 EDT 2015
Finished at Wed Aug 19 10:14:09 EDT 2015

/tmp/melFromFeeds-struct7dof-standard2mmNonlinear.ica
17 minutes:
Started at Wed Aug 19 10:18:18 EDT 2015
Finished at Wed Aug 19 10:33:22 EDT 2015

/tmp/melFromFeeds-struct12dof-standard2mmNonlinear.ica
17 minutes:
Started at Wed Aug 19 11:12:43 EDT 2015
Finished at Wed Aug 19 11:28:23 EDT 2015

/tmp/melFromFeeds-structBBR-standard2mmNonlinear.ica
23 minutes:
Started at Wed Aug 19 10:37:23 EDT 2015
Finished at Wed Aug 19 10:59:54 EDT 2015
```

## moved melodic results from /tmp

```bash
[12:00:04]-[stowler-local]-at-[pano]-in-[/tmp]
$ ls -ald /tmp/melFromFeeds-*
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 11:44 /tmp/melFromFeeds-struct12dof-standard2mmLinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 11:28 /tmp/melFromFeeds-struct12dof-standard2mmNonlinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 11:53 /tmp/melFromFeeds-struct12dof-standardNone.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 09:06 /tmp/melFromFeeds-struct6dof-standard2mmLinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 10:14 /tmp/melFromFeeds-struct6dof-standard2mmNonlinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 08:05 /tmp/melFromFeeds-struct6dof-standardNone.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 09:35 /tmp/melFromFeeds-struct7dof-standard2mmLinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 10:33 /tmp/melFromFeeds-struct7dof-standard2mmNonlinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 08:33 /tmp/melFromFeeds-struct7dof-standardNone.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 09:55 /tmp/melFromFeeds-structBBR-standard2mmLinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 10:59 /tmp/melFromFeeds-structBBR-standard2mmNonlinear.ica
drwxrwxr-x 7 stowler-local stowler-local 4096 Aug 19 08:48 /tmp/melFromFeeds-structBBR-standardNone.ica

[12:00:35]-[stowler-local]-at-[pano]-in-[/tmp]
$ du -sh /tmp/melFromFeeds-*
64M     /tmp/melFromFeeds-struct12dof-standard2mmLinear.ica
94M     /tmp/melFromFeeds-struct12dof-standard2mmNonlinear.ica
60M     /tmp/melFromFeeds-struct12dof-standardNone.ica
64M     /tmp/melFromFeeds-struct6dof-standard2mmLinear.ica
94M     /tmp/melFromFeeds-struct6dof-standard2mmNonlinear.ica
60M     /tmp/melFromFeeds-struct6dof-standardNone.ica
64M     /tmp/melFromFeeds-struct7dof-standard2mmLinear.ica
94M     /tmp/melFromFeeds-struct7dof-standard2mmNonlinear.ica
60M     /tmp/melFromFeeds-struct7dof-standardNone.ica
90M     /tmp/melFromFeeds-structBBR-standard2mmLinear.ica
104M    /tmp/melFromFeeds-structBBR-standard2mmNonlinear.ica
86M     /tmp/melFromFeeds-structBBR-standardNone.ica

[12:01:15]-[stowler-local]-at-[pano]-in-[/tmp]
$ mv /tmp/melFromFeeds-* /data/panolocal/tempStowler/
```

# updated pano and rebooted

_yesterday pano had a number of updates that require rebooting...held until I heard from Keith that he hadn't already configured automount of /data/panolocal_

```bash
$ sudo apt-get update

[12:04:51]-[stowler-local]-at-[pano]-in-[/tmp]
$ sudo apt-get dist-upgrade
Reading package lists... Done
Building dependency tree
Reading state information... Done
Calculating upgrade... Done
The following packages will be upgraded:
  chromium-codecs-ffmpeg-extra openssh-client openssh-server
  openssh-sftp-server ssh
5 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Need to get 1,770 kB of archives.
After this operation, 32.8 kB disk space will be freed.
Do you want to continue? [Y/n] Y

# confirmed that aptitude didn't have any pending conflicts:
[12:08:10]-[stowler-local]-at-[pano]-in-[/tmp]
$ sudo aptitude

[12:09:50]-[stowler-local]-at-[pano]-in-[~]
$ sudo shutdown -r now
```

