# stowler BIRC system config: pano.birc.emory.edu on 20150819

_config and testing in progress..._

# tested Melodic in prep for testing FIX

Testing Melodic using FSL FEED's `fmri.nii.gz`, `structural.nii.gz`, and `structural_brain.nii.gz`.

Monitored w/out web browser ("Progress Watcher" off in Melodic GUI):
- "Started" stamp is in `report_log.html`, even after completion
- "Finished" stamp is in `report.html` (has started stamp until completion)

For example:
```bash
$ grep -IEr "Started|Finished" /tmp/melFromFeeds-*.ica/*
/tmp/melFromFeeds-struct6dof-standard2mmLinear.ica/logs/feat0:Started at Wed Aug 19 08:59:13 EDT 2015<p>
/tmp/melFromFeeds-struct6dof-standard2mmLinear.ica/report.html:Finished at Wed Aug 19 09:06:57 EDT 2015
/tmp/melFromFeeds-struct6dof-standard2mmLinear.ica/report_log.html:Started at Wed Aug 19 08:59:13 EDT 2015<p>
/tmp/melFromFeeds-struct6dof-standardNone.ica/logs/feat0:Started at Wed Aug 19 07:57:51 EDT 2015<p>
/tmp/melFromFeeds-struct6dof-standardNone.ica/report.html:Finished at Wed Aug 19 08:05:03 EDT 2015
/tmp/melFromFeeds-struct6dof-standardNone.ica/report_log.html:Started at Wed Aug 19 07:57:51 EDT 2015<p>
# ...snip...
```

## tested melodic with no registration to standard template

Iterating over epi2struct registration method: 6 dof, 7 dof, or BBR.

```
/tmp/melFromFeeds-struct6dof-standardNone.ica
7 minutes:
Started at Wed Aug 19 07:57:51 EDT 2015
Finished at Wed Aug 19 08:05:03 EDT 2015

/tmp/melFromFeeds-struct7dof-standardNone.ica
8 minutes:
Started at Wed Aug 19 08:25:44 EDT 2015
Finished at Wed Aug 19 08:33:28 EDT 2015

/tmp/melFromFeeds-structBBR-standardNone.ica
14 minutes:
Started at Wed Aug 19 08:35:22 EDT 2015
Finished at Wed Aug 19 08:48:48 EDT 2015

```

## tested melodic with linear only registration to standard template

Iterating over epi2struct registration method: 6 dof, 7 dof, or BBR.

```
/tmp/melFromFeeds-struct6dof-standard2mmLinear.ica
8 minutes:
Started at Wed Aug 19 08:59:13 EDT 2015
Finished at Wed Aug 19 09:06:57 EDT 2015

/tmp/melFromFeeds-struct7dof-standard2mmLinear.ica
8 minutes:
Started at Wed Aug 19 09:27:41 EDT 2015
Finished at Wed Aug 19 09:35:45 EDT 2015

/tmp/melFromFeeds-structBBR-standard2mmLinear.ica
15 minutes:
Started at Wed Aug 19 09:40:26 EDT 2015
Finished at Wed Aug 19 09:55:01 EDT 2015
```

## tested melodic with nonlinear registration to standard template

Iterating over epi2struct registration method: 6 dof, 7 dof, or BBR.

```
/tmp/melFromFeeds-struct6dof-standard2mmNonlinear.ica
16 minutes:
Started at Wed Aug 19 09:58:45 EDT 2015
Finished at Wed Aug 19 10:14:09 EDT 2015

/tmp/melFromFeeds-struct7dof-standard2mmNonlinear.ica
17 minutes:
Started at Wed Aug 19 10:18:18 EDT 2015
Finished at Wed Aug 19 10:33:22 EDT 2015

/tmp/melFromFeeds-structBBR-standard2mmNonlinear.ica
23 minutes:
Started at Wed Aug 19 10:37:23 EDT 2015
Finished at Wed Aug 19 10:59:54 EDT 2015
```
