# stowler BIRC system config: pano and rama on Tuesday 20150825

_config and testing in progress..._

Contents
=================


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

## gridengine: test on MELODIC group ICA

Copied files from pano to duplicate yesterday's testing. Topped out at about 80 MB/s, mean 35-40:
```bash
[14:25:08]-[stowler-local]-at-[pano]-in-[/data/panolocal]
$ du -sh /data/panolocal/tempStowler
50G	/data/panolocal/tempStowler

[14:26:33]-[stowler-local]-at-[rama]-in-[~]
$ rsync -av --progress stowler-local@pano:/data/panolocal/tempStowler /data/panolocal/
```

## melview: install and test

Installed and tested melview. Recorded [commands and stdout][] for future troubleshooting.

[commands and stdout]: https://github.com/CVNRneuroimaging/infrastructure/blob/master/config/notes/20150825-stowlerInstalledMelviewOnRama.md
