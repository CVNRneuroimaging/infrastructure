#!/bin/sh

set -x

USER=
PASSWORD=
COMMAND=LXDE
SESSION_TIMEOUT=120

SESSION_PID=`x2golistsessions| cut -f 1 -d "|"`
if [ x"$SESSION_PID" != "x" ]; then
    echo "session exists", $SESSION_PID
    exit
fi


XVFB_DISPLAY=:12
XEPHYR_DISPLAY=:11

Xvfb -screen 0 1024x768x24 $XVFB_DISPLAY &
XVFB_PID=$!
DISPLAY=$XVFB_DISPLAY Xephyr -screen  800x600x24  $XEPHYR_DISPLAY &
XEPHYR_PID=$!

START_TIME=`date +"%s"`

DISPLAY=$XEPHYR_DISPLAY pyhoca-cli --server localhost -u $USER --password $PASSWORD -t desktop -c $COMMAND &
CLI_PID=$!


while [ true ]; do 
    NOW_TIME=`date +"%s"`
    SESSION_PID=`x2golistsessions| cut -f 1 -d "|"`
    ELAPSED_TIME=`expr $NOW_TIME - $START_TIME`
    echo $SESSION_PID
    if [ x"$SESSION_PID" != "x" ]; then
		echo "session started", $SESSION_PID
		break
    fi
    if [ $ELAPSED_TIME -gt $SESSION_TIMEOUT ]; then
		echo "session timed out before starting"
		break
    fi
    sleep 5
done


/bin/kill -SIGTERM $CLI_PID
/bin/kill -SIGKILL  $XVFB_PID



