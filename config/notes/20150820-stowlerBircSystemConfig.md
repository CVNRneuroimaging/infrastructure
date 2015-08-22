# stowler BIRC system config: pano.birc.emory.edu on Thursday 20150820

_More config and testing to be done, but here are today's notes._

_TBD: fix pano's CTRL-ALT-DEL problem_

Contents
=================

  * [pano: missing login box](#pano-missing-login-box)
  * [fixed pano: display manager crashes upon login](#fixed-pano-display-manager-crashes-upon-login)
  * [FSL FIX: launched remaining serial tests](#fsl-fix-launched-remaining-serial-tests)
  * [FSL FIX: inspected results of serial tests outside of melview](#fsl-fix-inspected-results-of-serial-tests-outside-of-melview)
  * [MELODIC group ICA: ran test on known\-good CLEANED sample data](#melodic-group-ica-ran-test-on-known-good-cleaned-sample-data)

# pano: missing login box

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


# FSL FIX: launched remaining serial tests

- 7am: Launched loop of serial FIX operations that should finish before 1p. (Generating known-good test data for MELODIC group ICA). Executed using script [melFromFeeds-testSingleSessions.sh](https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/tests-melodicAndFix-201508/melFromFeeds-testSingleSessions.sh) .
 
- 11:40: completed. Moved output from /tmp to /data/panolocal/tempStowler/

# FSL FIX: inspected results of serial tests outside of melview

Ran [melFromFeeds-extractNoiseComps.sh](https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/tests-melodicAndFix-201508/melFromFeeds-extractNoiseComps.sh) to extract list of noise components from each `fix4melview_Standard_thr*.txt` file:

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


# MELODIC group ICA: ran test on known-good CLEANED sample data

Launched via melodic GUI with GUI progress watcher turned off. List of input images from [melFromFeeds-generateList-filtered_func_data.sh](https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/tests-melodicAndFix-201508/melFromFeeds-generateList-filtered_func_data.sh) and [melFromFeeds-36T1s.txt](https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/tests-melodicAndFix-201508/melFromFeeds-36T1s.txt).

Completed group ICA of 36 FIX-cleaned "sessions" in about 12 hours:

```
[10:02:47]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ bwMelodicProgress.sh /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Progress of the melodic creating output in /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica:
drwxrwxr-x 5 stowler-local stowler-local 4096 Aug 20 22:02 /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

Melodic Started at Thu Aug 20 22:02:28 EDT 2015 :
884K    /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
...but melodic not yet finished as of Thu Aug 20 22:03:02 EDT 2015. Will check again in 20 seconds...

...snip...

Melodic Started at Thu Aug 20 22:02:28 EDT 2015 :
155M    /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
...but melodic not yet finished as of Fri Aug 21 10:07:21 EDT 2015. Will check again in 20 seconds...

Finished at Fri Aug 21 10:07:40 EDT 2015

```

