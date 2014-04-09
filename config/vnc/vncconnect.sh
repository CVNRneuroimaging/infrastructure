#!/bin/bash
set -x
SERVER="$1"

VNCDISPLAY=`ssh $SERVER /usr/bin/vncstart.sh`


vncviewer -shared -tunnel $SERVER:$VNCDISPLAY