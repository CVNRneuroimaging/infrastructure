# stowler BIRC system config: pano.birc.emory.edu on 20150821

_...config and tesing in progress..._

_TBD: fix pano's CTRL-ALT-DEL problem_


# MELODIC group ICA: inspect test results from known-good CLEANED sample data

_TBD: visually inspect results_

Yesterday's group ICA run completed around 10am today (~12 hrs):
```
Melodic Started at Thu Aug 20 22:02:28 EDT 2015 :
155M    /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
...but melodic not yet finished as of Fri Aug 21 10:07:21 EDT 2015. Will check again in 20 seconds...

Finished at Fri Aug 21 10:07:40 EDT 2015
```

Noted that the input directories received writes until the last ~1.5 hrs of the total 12-hr processing, and that they have grown significantly (~14 GB from ~4 GB):

```bash
[11:17:06]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ find . -type f -printf '%T@ %p\n' | sort -n | tail -5 | cut -f2- -d" " | xargs ls -al
-rw-rw-r-- 1 stowler-local stowler-local   3467074 Aug 21 08:47 ./fixThresh16/melFromFeeds-struct6dof-standardNone.ica/filtered_func_data_clean_melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.ica/reg_standard/bg_image.nii.gz
-rw-rw-r-- 1 stowler-local stowler-local 243615959 Aug 21 08:48 ./fixThresh16/melFromFeeds-struct6dof-standardNone.ica/filtered_func_data_clean_melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.ica/reg_standard/filtered_func_data.nii.gz
-rw-rw-r-- 1 stowler-local stowler-local     10881 Aug 21 08:48 ./fixThresh16/melFromFeeds-struct6dof-standardNone.ica/filtered_func_data_clean_melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.ica/reg_standard/mask.nii.gz
-rw-rw-r-- 1 stowler-local stowler-local    533672 Aug 21 08:47 ./fixThresh16/melFromFeeds-struct6dof-standardNone.ica/filtered_func_data_clean_melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.ica/reg_standard/standard.nii.gz
-rw-rw-r-- 1 stowler-local stowler-local     12362 Aug 21 08:48 ./fixThresh16/melFromFeeds-struct6dof-standardNone.ica/filtered_func_data_clean_melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.ica/report_log.html

[11:32:06]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ du -sh fixThresh*
4.7G    fixThresh16
4.7G    fixThresh18
4.7G    fixThresh20

[11:32:19]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ du -sh fixThresh*/* | head -n 5
385M    fixThresh16/melFromFeeds-struct12dof-standard2mmLinear.ica
415M    fixThresh16/melFromFeeds-struct12dof-standard2mmNonlinear.ica
381M    fixThresh16/melFromFeeds-struct12dof-standardNone.ica
385M    fixThresh16/melFromFeeds-struct6dof-standard2mmLinear.ica
415M    fixThresh16/melFromFeeds-struct6dof-standard2mmNonlinear.ica
```

## stored the gica results and reset the single-session ICA data for next test

Moved the output from /tmp to external drive:
```bash
[11:23:43]-[stowler-local]-at-[pano]-in-[/tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica]
$ du -sh /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica
159M    /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica

[11:23:50]-[stowler-local]-at-[pano]-in-[/tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica]
$ mkdir /data/panolocal/tempStowler/resultsGroupICA

[11:25:16]-[stowler-local]-at-[pano]-in-[/tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica]
$ mv /tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica /data/panolocal/tempStowler/resultsGroupICA/

[11:25:48]-[stowler-local]-at-[pano]-in-[/tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica]
$ sync

[11:25:55]-[stowler-local]-at-[pano]-in-[/tmp/melFromFeeds-groupICA-inputsCleaned-temporalCat-structBBR-standard2mmNonlinear.gica]
$
``` 

Archived the input data, now altered by the groupICA:

```bash
[11:34:59]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ tar -cvf melFromFeeds-afterFixAndGroupIcaOfCleaned.tar fixThresh*
```

Reset input data for upcoming group ICA of known-good UNCLEANED sample data:

```bash
[11:43:07]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ rm -fr fixThresh*

[11:44:51]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ tar -xvf melFromFeeds-afterFix.tar

# as expected, single-session ica dirs are back to their pre-groupICA sizes:
[11:46:12]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ du -sh fixThresh*
1.2G    fixThresh16
1.2G    fixThresh18
1.2G    fixThresh20

[11:46:25]-[stowler-local]-at-[pano]-in-[/data/panolocal/tempStowler]
$ du -sh fixThresh*/* | head -n 5
81M     fixThresh16/melFromFeeds-struct12dof-standard2mmLinear.ica
111M    fixThresh16/melFromFeeds-struct12dof-standard2mmNonlinear.ica
77M     fixThresh16/melFromFeeds-struct12dof-standardNone.ica
80M     fixThresh16/melFromFeeds-struct6dof-standard2mmLinear.ica
110M    fixThresh16/melFromFeeds-struct6dof-standard2mmNonlinear.ica
```

# melview: install and test

I installed using steps below, then tested by visualizing recent melFromFeeds FIX output (see notes from last few days). For future troubleshooting I pasted the install's relevant stdout to its own [file](https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/notes/20150821-stowlerInstalledMelviewOnPano.md).

Three install steps:

## 1) installed dependencies per README and melview [webpage](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Melview)

```bash
[01:00:29]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos]
$ sudo apt-get install python-configobj python-enthoughtbase python-matplotlib python-nibabel python-pyface python-pyside python-traits python-traitsui 
```

## 2) ran install command per melview [webpage](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Melview)

```bash
[01:07:58]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos/melview] on master
$ sudo python ./setup.py install
```

## 3) confirmed location of installed melview executables:

...and that they're not symlinks:

```bash
[01:11:43]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos/melview] on master
$ which melview | xargs ls -l
-rwxr-xr-x 1 root root 301 Aug 21 13:08 /usr/local/bin/melview

[01:12:00]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos/melview] on master
$ which mv2fix | xargs ls -l
-rwxr-xr-x 1 root root 299 Aug 21 13:08 /usr/local/bin/mv2fix
```

# FSLNets: install

TBD

# FSLNets: test on known-good sample data

_(test on something outside of melFromFeeds lineage)_

TBD

# MELODIC dual-regression: test on known-good CLEANED sample data

TBD

# MELODIC group ICA: launched test on known-good UNCLEANED sample data

TBD
