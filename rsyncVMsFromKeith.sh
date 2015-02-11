#!/bin/sh

# rsync Keith's VMs from the server to local machines that don't mount hippostore:/data :

remoteUser=$1

rsync -rv --progress ${remoteUser}@qball3.birc.emory.edu:/data/birc/Atlanta/IT_STUFF/XubuntuBirc021015_LDAP /data/birc/Atlanta/IT_STUFF/
