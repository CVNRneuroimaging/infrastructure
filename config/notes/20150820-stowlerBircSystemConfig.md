# stowler BIRC system config: pano.birc.emory.edu on 20150820

_...config and testing in progress..._

# testing FIX (continued)

7am: launched loop of serial FIX operations that should finish before 1p. (Generating known-good test data for MELODIC group ICA)
11:40: completed, moved from /tmp to /data/panolocal/tempStowler/


```bash
#!/bin/bash

# Quick and dirty iteration of three FIX thresholds over 12 MELODIC outputs
# that were derived from FSL FEEDS fmri.nii.gz.

# Estimate of total time: 5.4 hours (9 minutes per run X 12 runs X 3 thresh)

# Work will be done on system drive instead of external or network:
rm -fr /tmp/fixThresh*

trainingFile=/opt/fix/training_files/Standard.RData

while read line; do
   icaRun=${line}
   for fixThresh in 20 18 16; do
      # Work will be done on system drive instead of external or network:
      mkdir /tmp/fixThresh${fixThresh}
      cp -R /data/panolocal/tempStowler/${icaRun} /tmp/fixThresh${fixThresh}/
      echo ""
      echo "######################################"
      date
      echo "Launching FIX:"
      echo "training file: ${trainingFile}"
      echo "ICA RUN:       ${icaRun}"
      echo "FIX threshold: ${fixThresh}"
      echo "FIX version:"
      which fix | xargs dirname | xargs ls -l
      echo "######################################"
      /usr/bin/time fix /tmp/fixThresh${fixThresh}/${icaRun} ${trainingFile} ${fixThresh} -m
      echo ""
      echo "FIX complete for thresh ${fixThresh} of ${icaRun}."
      echo "All related output directories:"
      du -sh /tmp/fixThresh*/*
      echo ""
   done #thresh loop
done <<EOM
melFromFeeds-structBBR-standard2mmNonlinear.ica
melFromFeeds-structBBR-standard2mmLinear.ica
melFromFeeds-structBBR-standardNone.ica
melFromFeeds-struct12dof-standard2mmNonlinear.ica
melFromFeeds-struct12dof-standard2mmLinear.ica
melFromFeeds-struct12dof-standardNone.ica
melFromFeeds-struct6dof-standard2mmNonlinear.ica
melFromFeeds-struct6dof-standard2mmLinear.ica
melFromFeeds-struct6dof-standardNone.ica
melFromFeeds-struct7dof-standard2mmNonlinear.ica
melFromFeeds-struct7dof-standard2mmLinear.ica
melFromFeeds-struct7dof-standardNone.ica
EOM

```

# pano: missing unlock prompt on display manager

Locked pano's desktop when I left last night, and now console shows wallpaper and responsive mouse but no login box. No problems connecting to existing tmux sessions via ssh, but I need access to the GUI app states from yesterday.

Moved data from /tmp and rebooted:
```bash
[11:49:13]-[stowler-local]-at-[pano]-in-[~/src.mywork.gitRepos/infrastructure/config/testMelodic] on master [?]
$ du -sh /tmp/fixThresh*
1.2G    /tmp/fixThresh16
1.2G    /tmp/fixThresh18
1.2G    /tmp/fixThresh20

[11:50:33]-[stowler-local]-at-[pano]-in-[~/src.mywork.gitRepos/infrastructure/config/testMelodic] on master [?]
$ cd /tmp

[11:50:44]-[stowler-local]-at-[pano]-in-[/tmp]
$ mv fixThresh* /data/panolocal/tempStowler/

[11:51:29]-[stowler-local]-at-[pano]-in-[/tmp]
$ sync

[11:55:50]-[stowler-local]-at-[pano]-in-[/tmp]
$ sudo shutdown -r now
```

Didn't help. Apparently as of 14.04 ubuntu isn't using xscreensaver [anymore](http://xubuntu.org/news/screen-locking-in-xubuntu-14-04/), so :
```bash
[12:23:22]-[stowler-local]-at-[pano]-in-[~]
$ sudo apt-get autoremove xscreensaver xscreensaver-data xscreensaver-gl

# resovled aptitude conflicts & security updates, rebooted.
```

Closer: now only fails to display unlock prompt after locking with CTRL-ALT-DEL.


# pano: display manager crashes upon login

Getting lightdm crashes upon login. Trying to reset lightdm settings:

```bash
[12:50:10]-[stowler-local]-at-[pano]-in-[~]
$ sudo apt-get install --reinstall lightdm

[12:50:54]-[stowler-local]-at-[pano]-in-[~]
$ sudo shutdown -r now
```
