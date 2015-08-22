# stowler BIRC system config: pano.birc.emory.edu on Wednesday 20150819

_More config and testing to be done, but this is what I completed today._

Contents
=================

  * [tested melodic in preparation for testing FIX](#tested-melodic-in-preparation-for-testing-fix)
    * [ran melodic with no registration to standard template](#ran-melodic-with-no-registration-to-standard-template)
    * [ran melodic with linear only registration to standard template](#ran-melodic-with-linear-only-registration-to-standard-template)
    * [ran melodic with nonlinear registration to standard template](#ran-melodic-with-nonlinear-registration-to-standard-template)
    * [moved melodic results from /tmp](#moved-melodic-results-from-tmp)
    * [inspected melodic registrations](#inspected-melodic-registrations)
    * [inspected melodic components](#inspected-melodic-components)
  * [updated pano and rebooted](#updated-pano-and-rebooted)
  * [tested FIX](#tested-fix)


# tested melodic in preparation for testing FIX

_Bottom line: no unexpected output from MELODIC on 14.04. Produced 12 unique datasets for FIX from FSL FEEDS `fmri.nii.gz`, `structural.nii.gz`, and `structural_brain.nii.gz`._

For remote monitoring without web browser (i.e., "Progress Watcher" off in Melodic GUI), using my script [bwMelodicProgress.sh](https://github.com/stowler/brainwhere/blob/master/bwMelodicProgress.sh).

## ran melodic with no registration to standard template

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

## ran melodic with linear only registration to standard template

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

## ran melodic with nonlinear registration to standard template

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

## inspected melodic registrations 

_Bottom line: 1) No unexpected interactions between epi2struct and struct2std methods. 2) As expected BBR + nonlinear reg produced best result. 3) Unexpected: 7dof worse than 12 and 6._

- epi2struct ("example_func to highres")
   - SANITY CHECK: no, not affected by choice of struct2std method
   - as expected, 12dof better than 6 or 7 (7 worst...has some roll and translation relative to others)
   - alignment of internal structures: BBR > 12dof
   - alignment of external boundaries: BBR > 12dof
- struct2std ("highres to standard")
   - SANITY CHECK: no, not affected by choice of epi2struct method
   - nonlinear reg produced fewer structural voxels outside of standard mask than linear reg did 

## inspected melodic components 

_Visually inspected 132 melodic components: 12 melodic runs (from melFromFeeds above) X 11 components. This confimed that each of the 11 inspected components were detected in all 12 melodic runs, though compontent order differed among runs, which is to be expected even without the variability introduced by registration technique._

I visually inspected the 12 ICA outputs with temporal domain as primary, freq domain and space as secondary. Found that the first three components are temporally identical across all 12 registration methods, with minor spatial differences in suprathreshold voxel memberships.

Numbering components 4 through 10 and 22 according to their order in the melodic output from structBBR-standard2mmNonlinear, I confirmed that each of the remaining eight components were detected in the other 11 melodic runs, noting the variability in component order in [this spreadsheet][] "melodic ICA component consistency across registration technique".

[this spreadsheet]: https://docs.google.com/spreadsheets/d/1HaL5tTo4QJFgPWm8YkN_l3rYkZSHbKsh_M75eziGEJw/edit?usp=sharing

# updated pano and rebooted

_yesterday pano had a number of updates that required rebooting...held reboot until I heard from Keith that he hadn't already configured automount of /data/panolocal_

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

# tested FIX 

Copied two MELODIC output directories to `/tmp` for initial testing under three FIX variations: thresholds of 20, 18, and 16:

```bash
$ mkdir /tmp/fixThresh20
$ cd /data/panolocal/tempStowler
$ cp -a melFromFeeds-structBBR-standardNone.ica         /tmp/fixThresh20/
$ cp -a melFromFeeds-structBBR-standard2mmNonlinear.ica /tmp/fixThresh20/
$ cp -a /tmp/fixThresh20 /tmp/fixThresh18
$ cp -a /tmp/fixThresh20 /tmp/fixThresh16
```

Run FIX serially on two inputs, with three thresholds per input:
```bash
$ trainingFile=/opt/fix/training_files/Standard.RData

# first structBBR-standardNone with three different thresholds:
$ icaRun=melFromFeeds-structBBR-standardNone.ica
$ thresh=20
$ /usr/bin/time fix /tmp/fixThresh${thresh}/${icaRun} ${trainingFile} ${thresh} -m
$ thresh=18
$ /usr/bin/time fix /tmp/fixThresh${thresh}/${icaRun} ${trainingFile} ${thresh} -m
$ thresh=16
$ /usr/bin/time fix /tmp/fixThresh${thresh}/${icaRun} ${trainingFile} ${thresh} -m
# elapsed times: 8:28.42 , 8:46.81 , and 8:27.57

# ...then structBBR-standard2mmNonlinear with three different thresholds:
icaRun=melFromFeeds-structBBR-standard2mmNonlinear.ica
$ thresh=20
$ /usr/bin/time fix /tmp/fixThresh${thresh}/${icaRun} ${trainingFile} ${thresh} -m
$ thresh=18
$ /usr/bin/time fix /tmp/fixThresh${thresh}/${icaRun} ${trainingFile} ${thresh} -m
$ thresh=16
$ /usr/bin/time fix /tmp/fixThresh${thresh}/${icaRun} ${trainingFile} ${thresh} -m
# elapsed times: 7:04.74, 7:05.77 , 7:05.79
```
