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
