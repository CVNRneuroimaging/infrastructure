#!/bin/bash

#set -x

USER=`whoami`
SSH_PRIVKEY=/home/$USER/.ssh/id_rsa
#PASSWORD=
COMMAND=LXDE
SESSION_TIMEOUT=120

SESSION_PID=`x2golistsessions| cut -f 1 -d "|"`
if [ x"$SESSION_PID" != "x" ]; then
    echo "session exists", $SESSION_PID
    exit
fi

# check if user is permitted ... 
# this is for admin convenience, not security
if [ ! -e "/etc/x2gousers/$USER" ]; then
    echo "user unknown or not permitted"
    exit 1
fi


XVFB_DISPLAY=:12
XEPHYR_DISPLAY=:11

Xvfb -screen 0 1024x768x24 $XVFB_DISPLAY &
XVFB_PID=$!
DISPLAY=$XVFB_DISPLAY Xephyr -screen  800x600x24  $XEPHYR_DISPLAY &
XEPHYR_PID=$!


function terminate_xservers  {
    /bin/kill -9 $XVFB_PID
    /bin/kill -9 $XEPHYR_PID
}



sleep 1
# make sure we started up
/bin/kill -SIGWINCH $XVFB_PID
RES1=$?
/bin/kill -SIGWINCH $XEPHYR_PID
RES2=$?

if [ 0 -ne $RES1 ] || [ 0 -ne  $RES2 ]; then
    echo "Couldn't start x servers"
    # cleanup if only one started
    terminate_xservers
    exit 1
fi

START_TIME=`date +"%s"`

DISPLAY=$XEPHYR_DISPLAY pyhoca-cli --server localhost -u $USER -t desktop -c $COMMAND -k $SSH_PRIVKEY & 
CLI_PID=$!


while [ true ]; do 
    NOW_TIME=`date +"%s"`
    SESSION_PID=`x2golistsessions| cut -f 1 -d "|"`
    ELAPSED_TIME=`expr $NOW_TIME - $START_TIME`
    #echo $SESSION_PID
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
terminate_xservers




