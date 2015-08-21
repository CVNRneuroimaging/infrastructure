# stowler BIRC system config: pano.birc.emory.edu on 20150820

_...config and testing in progress..._
- _TBD: fix pano's CTRL-ALT-DEL problem_


# pano: missing unlock box for username/password

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


# fixed pano: display manager crashes upon login

Lightdm crashes upon login. Fixed by resetting lightdm settings:

```bash
[12:50:10]-[stowler-local]-at-[pano]-in-[~]
$ sudo apt-get install --reinstall lightdm

[12:50:54]-[stowler-local]-at-[pano]-in-[~]
$ sudo shutdown -r now
```
# ran remaining FIX tests

- 7am: launched loop of serial FIX operations that should finish before 1p. (Generating known-good test data for MELODIC group ICA)
- 11:40: completed, moved from /tmp to /data/panolocal/tempStowler/


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
# inspected FIX results outside of melview

Extracted list of noise components from each `fix4melview_Standard_thr*.txt` file:

```bash
#!/bin/bash

# Quick and dirty extraction of the last line from all
# fix4melview_Standard_thr${fixThresh}.txt files so that FIX-identified noise components
# can be compared across registration methods and FIX thresholds.

parentDir='/data/panolocal/tempStowler'
tempFile=/tmp/fixResults.txt
columnFile=/tmp/fixColumns.txt

rm -f ${tempFile}
rm -f ${columnFile}


for methodEpiToStruct in BBR 12dof 7dof 6dof; do
   for methodStructToStd in 2mmNonlinear 2mmLinear None; do
      for fixThresh in 20 18 16; do
         classFile=${parentDir}/fixThresh${fixThresh}/melFromFeeds-struct${methodEpiToStruct}-standard${methodStructToStd}.ica/fix4melview_Standard_thr${fixThresh}.txt
         noiseList="`sed -n '$p' $classFile`"
         echo "struct${methodEpiToStruct} standard${methodStructToStd} fixThresh${fixThresh} ${noiseList}" >> ${tempFile}
      done # fixThresh
   done # methodStructToStd
done # methodEpiToStruct

column -t ${tempFile} > ${columnFile}
cat ${columnFile}
```

...which outputs:

```
structBBR    standard2mmNonlinear  fixThresh20  [1,  4,  6,  8,  10,  11,  13,  16,  18,  20,  22,  24,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  46,  47,  48, 49,  50,  52,  53,  54,  57,  58,  61,  62,  64,  65]
structBBR    standard2mmNonlinear  fixThresh18  [1,  4,  6,  8,  10,  11,  13,  16,  18,  20,  22,  24,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  46,  47,  48, 49,  50,  52,  53,  54,  57,  58,  61,  62,  64,  65]
structBBR    standard2mmNonlinear  fixThresh16  [1,  4,  6,  8,  10,  11,  13,  16,  18,  20,  22,  24,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  46,  47,  48, 49,  50,  52,  53,  54,  57,  58,  61,  62,  64,  65]
structBBR    standard2mmLinear     fixThresh20  [1,  4,  6,  8,  11,  13,  14,  15,  17,  18,  20,  21,  25,  27,  30,  31,  32,  33,  35,  36,  38,  39,  40,  44,  45,  47,  48,  49, 50,  51,  52,  53,  56,  58,  59,  60,  61,  63,  65]
structBBR    standard2mmLinear     fixThresh18  [1,  4,  6,  8,  11,  13,  14,  15,  17,  18,  20,  21,  25,  27,  30,  31,  32,  33,  35,  36,  38,  39,  40,  44,  45,  47,  48,  49, 50,  51,  52,  53,  56,  58,  59,  60,  61,  63,  65]
structBBR    standard2mmLinear     fixThresh16  [1,  4,  6,  8,  11,  13,  14,  15,  17,  18,  20,  21,  25,  27,  30,  31,  32,  33,  35,  36,  38,  39,  40,  44,  45,  47,  48,  49, 50,  51,  52,  53,  56,  58,  59,  60,  61,  63,  65]
structBBR    standardNone          fixThresh20  [1,  4,  6,  8,  11,  12,  13,  14,  19,  21,  24,  25,  26,  27,  28,  29,  32,  33,  34,  35,  36,  39,  40,  45,  47,  48,  49,  50, 51,  52,  53,  58,  60,  61,  62,  64,  65]
structBBR    standardNone          fixThresh18  [1,  4,  6,  8,  11,  12,  13,  14,  19,  21,  24,  25,  26,  27,  28,  29,  32,  33,  34,  35,  36,  39,  40,  45,  47,  48,  49,  50, 51,  52,  53,  58,  60,  61,  62,  64,  65]
structBBR    standardNone          fixThresh16  [1,  4,  6,  8,  11,  12,  13,  14,  19,  21,  24,  25,  26,  27,  28,  29,  32,  33,  34,  35,  36,  39,  40,  45,  47,  48,  49,  50, 51,  52,  53,  58,  60,  61,  62,  64,  65]
struct12dof  standard2mmNonlinear  fixThresh20  [1,  4,  6,  8,  9,   11,  14,  16,  20,  21,  23,  24,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  41,  42,  45,  47,  48, 49,  50,  51,  53,  54,  55,  56,  57,  58,  60,  61,  63,  64,  65]
struct12dof  standard2mmNonlinear  fixThresh18  [1,  4,  6,  8,  9,   11,  14,  16,  20,  21,  23,  24,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  41,  42,  45,  47,  48, 49,  50,  51,  53,  54,  55,  56,  57,  58,  60,  61,  63,  64,  65]
struct12dof  standard2mmNonlinear  fixThresh16  [1,  4,  6,  8,  9,   11,  14,  16,  20,  21,  23,  24,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  41,  42,  45,  47,  48,  49, 50,  51,  53,  54,  55,  56,  57,  58,  60,  61,  63,  64,  65]
struct12dof  standard2mmLinear     fixThresh20  [1,  4,  5,  8,  10,  12,  14,  16,  17,  22,  24,  25,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  41,  44,  45,  47,  48, 49,  50,  51,  52,  53,  55,  57,  59,  60,  61,  62,  63]
struct12dof  standard2mmLinear     fixThresh18  [1,  4,  5,  8,  10,  12,  14,  16,  17,  22,  24,  25,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  39,  41,  44,  45,  47,  48, 49,  50,  51,  52,  53,  55,  57,  59,  60,  61,  62,  63]
struct12dof  standard2mmLinear     fixThresh16  [1,  4,  5,  8,  10,  12,  14,  16,  17,  22,  24,  25,  26,  28,  31,  32,  33,  34,  35,  36,  37,  38,  41,  44,  45,  47,  48,  49, 50,  51,  52,  53,  57,  59,  60,  61,  62,  63]
struct12dof  standardNone          fixThresh20  [1,  5,  7,  8,  9,   12,  13,  14,  17,  18,  21,  22,  26,  27,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  42,  45,  47,  48, 49,  50,  51,  54,  56,  58,  59,  60,  61,  63,  64,  65]
struct12dof  standardNone          fixThresh18  [1,  5,  7,  8,  9,   12,  13,  14,  17,  18,  21,  22,  26,  27,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  42,  45,  47,  48, 49,  50,  51,  54,  56,  58,  59,  60,  61,  63,  64,  65]
struct12dof  standardNone          fixThresh16  [1,  5,  7,  8,  9,   12,  13,  14,  17,  18,  21,  22,  26,  27,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  42,  45,  47,  48, 49,  50,  51,  54,  56,  58,  59,  60,  61,  63,  64,  65]
struct7dof   standard2mmNonlinear  fixThresh20  [1,  4,  5,  7,  10,  11,  13,  16,  18,  19,  21,  24,  26,  28,  31,  32,  33,  34,  35,  37,  39,  40,  41,  43,  44,  49,  50,  51, 52,  53,  54,  57,  58,  61,  63,  64,  65]
struct7dof   standard2mmNonlinear  fixThresh18  [1,  4,  5,  7,  10,  11,  13,  16,  18,  19,  21,  24,  26,  28,  31,  32,  33,  34,  35,  37,  39,  40,  41,  43,  44,  49,  50,  51,  52,  53,  54,  57,  58,  61,  63,  64,  65]
struct7dof   standard2mmNonlinear  fixThresh16  [1,  4,  5,  7,  10,  11,  13,  16,  18,  19,  21,  24,  26,  28,  31,  32,  33,  34,  35,  37,  39,  40,  41,  43,  44,  49,  50,  51,  52,  53,  54,  57,  58,  61,  63,  64,  65]
struct7dof   standard2mmLinear     fixThresh20  [1,  4,  5,  7,  10,  12,  14,  15,  17,  18,  22,  23,  26,  30,  31,  32,  33,  34,  35,  36,  37,  39,  40,  41,  42,  45,  47,  48,  49,  50,  51,  52,  53,  55,  56,  57,  58,  60,  62,  63,  64,  65]
struct7dof   standard2mmLinear     fixThresh18  [1,  4,  5,  7,  10,  12,  14,  15,  17,  18,  22,  23,  26,  30,  31,  32,  33,  34,  35,  36,  37,  39,  40,  41,  42,  45,  47,  48,  49,  50,  51,  52,  53,  55,  56,  57,  58,  60,  62,  63,  64,  65]
struct7dof   standard2mmLinear     fixThresh16  [1,  4,  5,  7,  10,  12,  14,  15,  17,  18,  22,  23,  26,  30,  31,  32,  33,  34,  35,  36,  37,  39,  40,  41,  42,  45,  47,  48,  49,  50,  51,  52,  53,  55,  56,  57,  58,  62,  63,  64,  65]
struct7dof   standardNone          fixThresh20  [1,  4,  6,  9,  10,  13,  14,  15,  17,  18,  23,  24,  26,  27,  28,  29,  32,  33,  34,  35,  36,  38,  40,  41,  42,  44,  46,  48,  49,  50,  51,  52,  53,  54,  55,  56,  58,  59,  61,  62,  64]
struct7dof   standardNone          fixThresh18  [1,  4,  6,  9,  10,  13,  14,  15,  17,  18,  23,  24,  26,  28,  29,  32,  33,  34,  35,  36,  38,  40,  41,  42,  44,  46,  48,  49,  50,  51,  52,  53,  54,  55,  56,  58,  59,  61,  62,  64]
struct7dof   standardNone          fixThresh16  [1,  4,  6,  9,  10,  13,  14,  15,  17,  18,  23,  24,  26,  28,  29,  32,  33,  34,  35,  36,  38,  40,  41,  42,  44,  46,  48,  49,  50,  51,  52,  53,  54,  55,  56,  58,  59,  61,  62,  64]
struct6dof   standard2mmNonlinear  fixThresh20  [1,  4,  5,  7,  9,   11,  13,  15,  17,  20,  21,  23,  27,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  46,  49,  50,  51,  53,  55,  56,  57,  59,  60,  61,  62,  64,  65]
struct6dof   standard2mmNonlinear  fixThresh18  [1,  4,  5,  7,  9,   11,  13,  15,  17,  20,  21,  23,  27,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  46,  49,  50,  51,  53,  55,  56,  57,  59,  60,  61,  62,  64,  65]
struct6dof   standard2mmNonlinear  fixThresh16  [1,  4,  5,  7,  9,   11,  13,  15,  17,  20,  21,  23,  27,  30,  31,  32,  33,  34,  36,  37,  38,  39,  40,  41,  46,  49,  50,  51,  53,  55,  56,  57,  59,  60,  61,  62,  64,  65]
struct6dof   standard2mmLinear     fixThresh20  [1,  7,  8,  9,  10,  13,  14,  15,  16,  18,  23,  24,  25,  26,  27,  30,  31,  34,  35,  36,  37,  38,  40,  41,  42,  43,  44,  49,  50,  51,  52,  53,  54,  55,  56,  58,  60,  61,  63]
struct6dof   standard2mmLinear     fixThresh18  [1,  7,  8,  9,  10,  13,  14,  15,  16,  18,  23,  24,  25,  26,  27,  30,  31,  34,  35,  36,  37,  38,  40,  41,  42,  43,  44,  49,  50,  51,  52,  53,  54,  55,  56,  58,  61,  63]
struct6dof   standard2mmLinear     fixThresh16  [1,  7,  8,  9,  10,  13,  14,  15,  16,  18,  23,  24,  25,  26,  27,  30,  31,  34,  35,  36,  37,  38,  40,  41,  42,  43,  44,  49,  50,  51,  52,  53,  54,  55,  56,  58,  61,  63]
struct6dof   standardNone          fixThresh20  [1,  4,  5,  7,  8,   12,  14,  15,  17,  18,  19,  25,  27,  28,  31,  32,  33,  34,  35,  36,  37,  39,  40,  41,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  56,  59,  60,  61,  63,  64,  65]
struct6dof   standardNone          fixThresh18  [1,  4,  5,  7,  8,   12,  14,  15,  17,  18,  19,  25,  27,  28,  31,  32,  33,  34,  35,  36,  37,  40,  41,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  56,  59,  60,  61,  63,  64,  65]
struct6dof   standardNone          fixThresh16  [1,  4,  5,  7,  8,   12,  14,  15,  17,  18,  19,  25,  27,  28,  31,  32,  33,  34,  35,  36,  37,  40,  41,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  56,  59,  60,  61,  63,  64,  65]
```

Created archive of results before applying group ICA and dual regression:

```bash
[09:23:28]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ tar -cvf melFromFeeds-afterFix.tar fixThresh*
```


# launched melodic test: group ica with cleaned inputs

```
[10:02:47]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ bwMelodicProgress.sh /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Progress of the melodic creating output in /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica:
drwxrwxr-x 5 stowler-local stowler-local 4096 Aug 20 22:02 /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Melodic Started at Thu Aug 20 22:02:28 EDT 2015 :
884K    /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
...but melodic not yet finished as of Thu Aug 20 22:03:02 EDT 2015. Will check again in 20 seconds...

...snip...


```

